module DistanceConcern
  extend ActiveSupport::Concern

  def distance(from, to)
    (from.lonlat.distance(to.lonlat)/1000).round(2)
  end
end
