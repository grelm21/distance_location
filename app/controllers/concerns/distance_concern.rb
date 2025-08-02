module DistanceConcern
  extend ActiveSupport::Concern

  def calculate_distance(from, to)
    (from.lonlat.distance(to.lonlat)/1000).round(2)
  end
end
