class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def search
    @locations = Api::YandexGeocoder.cities_and_towns(params[:query])

    render json: @locations.to_json
  end

  def create
    @location = Location.new(location_params.except(:lonlat))
    @location.lonlat = parse_point

    if @location.save
      render json: @location.to_json
    else
      render json: @location.errors.to_json, status: :unprocessable_entity
    end
  end

  def distance
    from = Location.find(params[:from_id])
    to = Location.find(params[:to_id])

    # @distance = Api::YandexGeocoder.distance(from, to)
    #
    # render json: @distance.to_json
    render json: { from: Geocoder.serach([from.lon, from.lat]), to: to[:name] }
  end

  private

  def parse_point
    points = location_params[:lonlat_string].split(' ').map(&:to_f)
    RGeo::Geographic.spherical_factory(srid: 4326).point(points[0], points[1])
  end

  def location_params
    params.require(:location).permit(:name, :lonlat_string, :lonlat)
  end
end
