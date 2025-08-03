module LocationsHelper
  def concat_name_and_coordinates(location)
    "#{location.name}, Координаты: #{location.lonlat_string}"
  end
end
