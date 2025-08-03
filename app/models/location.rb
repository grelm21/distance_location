class Location < ApplicationRecord
  attribute :raw_lonlat, :string
  validates :name, presence: true
  validates :raw_lonlat, format: {
    with: /\A-?\d+(\.\d+)?\s-?\d+(\.\d+)?\z/,
    message: 'wrong format'
  }
  validate :unique_record

  before_save :parse_lonlat

  def lonlat_string
    "#{lonlat.x}, #{lonlat.y}"
  end

  private

  def parse_lonlat
    coordinates = raw_lonlat.split(' ').map(&:to_f)
    self.lonlat = RGeo::Geographic.spherical_factory(srid: 4326).point(coordinates[0], coordinates[1])
  rescue StandardError => e
    Rails.logger.error(context: 'Location#parse_lonlat', message: 'Не удалось распарсить строку с координатами',
                       details: e.message)
    errors.add(:lonlat, 'could not parse lonlat coordinates')
  end

  def unique_record
    errors.add(:base, :not_unique_record) if Location.exists?(name: name)
  end
end
