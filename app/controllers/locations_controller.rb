class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  include CoordinatesConcern
  include DistanceConcern

  def search
    @locations = Api::YandexGeocoder.cities_and_towns(params[:query])

    render json: @locations.to_json
  end

  def index
    @locations = Location.all

    render json: @locations.to_json
  end

  def create
    @location = Location.new(location_params.except(:lonlat))
    @location.lonlat = parse_point(location_params[:lonlat_string])

    if @location.save
      render json: @location.to_json
    else
      render json: @location.errors.to_json, status: :unprocessable_entity
    end
  end

  def distance
    from = Location.find(params[:from_id])
    to = Location.find(params[:to_id])

    @distance = distance(from, to)

    render json: { from: from.name, to: to[:name], distance: @distance }
  end

  private

  def location_params
    params.require(:location).permit(:name, :lonlat_string, :lonlat)
  end
end
