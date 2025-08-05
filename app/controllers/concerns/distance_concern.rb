module DistanceConcern
  extend ActiveSupport::Concern

  def calculate_straight_distance(from, to)
    (from.lonlat.distance(to.lonlat)/1000).round(2)
  rescue StandardError
    raise DistanceHandler::DistanceCalculationError.new('DistanceConcern#calculate_distance')
  end
end
