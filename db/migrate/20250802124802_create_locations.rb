class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :lonlat_string
      t.st_point :lonlat

      t.timestamps
    end
  end
end
