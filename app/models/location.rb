class Location < ApplicationRecord
  attribute :point, :string, default: ''

  validates :name, presence: true
  before_validation :parse_point

  private

  def parse_point
    points = point.split(' ').map(&:to_f)
    self.lon = points[0]
    self.lat = points[1]
  end
end
