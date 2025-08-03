# frozen_string_literal: true
module CoordinatesConcern
  extend ActiveSupport::Concern

  def parse_point(point_string)
    points = point_string.split(' ').map(&:to_f)
    RGeo::Geographic.spherical_factory(srid: 4326).point(points[0], points[1])
  end
end
