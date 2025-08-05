# frozen_string_literal: true

class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  before_action :set_location, only: %i[show destroy]
  rescue_from DistanceHandler::DistanceDestinationsNotFoundError, DistanceHandler::DistanceCalculationError,
              with: :handle_distance_error

  include DistanceConcern

  def search
    @locations = Api::YandexGeocoder.cities_and_towns(params[:query])

    # render json: @locations.to_json
    respond_to do |format|
      format.json { render json: @locations.to_json }
      format.turbo_stream do
        html = render_to_string(partial: 'locations/search_result_wrapper',
                                locals: { locations: @locations[:result] || [],
                                          errors: @locations[:errors] || [],
                                          message: 'Не удалось получить локации' },
                                formats: [:html])
        render turbo_stream: [
          turbo_stream.update('search_result', html)
        ]
      end
    end
  end

  def index
    @locations = Location.all

    render json: @locations.to_json
  end

  def show
    render json: @location.to_json
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.turbo_stream do
          html = render_to_string(partial: 'locations/search_result_wrapper',
                                  locals: { locations: nil, errors: [] }, formats: [:html])
          render turbo_stream: [
            turbo_stream.update('search_result', html),
            turbo_stream.prepend('locations', @location),
            turbo_stream.update('distance_selectors', partial: 'locations/distance_selectors',
                                                      locals: { locations: Location.all }),
            turbo_stream.remove('locations_empty_notice')
          ]
        end
        format.json { render json: @location.to_json }
      else
        format.turbo_stream do
          html = render_to_string(partial: 'locations/search_result_wrapper',
                                  locals: { locations: nil, errors: @location.errors, message: 'Не удалось добавить локацию' }, formats: [:html])
          render turbo_stream: [
            turbo_stream.update('search_result', html)
          ]
        end
        format.json { render json: @location.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @location.destroy
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('locations', partial: 'locations/location', collection: Location.all,
                                             as: :location),
            turbo_stream.update('distance_selectors', partial: 'locations/distance_selectors',
                                                      locals: { locations: Location.all })
          ]
        end
        format.json { render json: @location.to_json }
      else
        format.json { render json: @location.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def distance
    set_from_to
    @distance = calculate_straight_distance(@from, @to)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('distance_result', partial: 'locations/distance_result',
                                                 locals: { distance: @distance,
                                                           from: @from.name, to: @to.name, error: nil })
        ]
      end
      format.json { render json: { from: @from.name, to: @to.name, distance: @distance } }
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :raw_lonlat)
  end

  def set_location
    @location = Location.find(params[:id])
  end

  def set_from_to
    unless params[:from_id].present? && params[:to_id].present?
      raise DistanceHandler::DistanceDestinationsNotFoundError, 'LocationsController#set_from_to'
    end

    @from = Location.find(params[:from_id])
    @to = Location.find(params[:to_id])
  end

  def handle_distance_error(e)
    Rails.logger.error(message: e.message, context: e.context)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('distance_result', partial: 'locations/distance_result',
                                                 locals: { distance: nil,
                                                           from: nil, to: nil, error: 'distance_error' })
        ]
      end
      format.json { render json: { error: e.message } }
    end
  end
end
