class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  include CoordinatesConcern
  include DistanceConcern

  def search
    @locations = Api::YandexGeocoder.cities_and_towns(params[:query])

    # render json: @locations.to_json
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('search_result', partial: 'locations/search_result', collection: @locations,
                                               as: :location)
        ]
      end
      format.json { render json: @locations.to_json }
    end
  end

  def index
    @locations = Location.all

    render json: @locations.to_json
  end

  def create
    @location = Location.new(location_params.except(:lonlat))
    @location.lonlat = parse_point(location_params[:lonlat_string])

    respond_to do |format|
      if @location.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend('locations', @location)
          ]
        end
        format.json { render json: @location.to_json }
      else
        format.json { render json: @location.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.destroy
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('locations', partial: 'locations/location', collection: Location.all,
                                             as: :location)
          ]
        end
        format.json { render json: @location.to_json }
      else
        format.json { render json: @location.errors.to_json, status: :unprocessable_entity }
      end
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
