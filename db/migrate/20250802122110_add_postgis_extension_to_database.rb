class AddPostgisExtensionToDatabase < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'postgis'

    create_table :spatial_table do |t|
      t.st_point :lonlat, geographic: true
    end
  end
end
