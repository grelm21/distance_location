class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create distance search]
  before_action :set_location, only: %i[destroy]

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
                                          message: 'Не далось получить локации' },
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
                                  locals: { locations: nil, errors: @location.errors, message: 'Не далось добавить локацию' }, formats: [:html])
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
    @distance = calculate_distance(@from, @to)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('distance_result', partial: 'locations/distance_result',
                                                 locals: { distance: @distance,
                                                           from: @from.name, to: @to.name, error: nil })
        ]
      end
      format.json { render json: { from: from.name, to: to[:name], distance: @distance } }
    end
  rescue DistanceHandler::DistanceDestinationsNotFoundError, DistanceHandler::DistanceCalculationError => e
    Rails.logger.error(message: e.message, context: e.context)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('distance_result', partial: 'locations/distance_result',
                                                 locals: { distance: nil,
                                                           from: nil, to: nil, error: e.message })
        ]
      end
      format.json { render json: { error: e.message } }
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
    raise DistanceHandler::DistanceDestinationsNotFoundError.new('LocationsController#set_from_to') unless params[:from_id].present? && params[:to_id].present?

    @from = Location.find(params[:from_id])
    @to = Location.find(params[:to_id])
  end
end
