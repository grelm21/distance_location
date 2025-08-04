class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :kind, default: 0
      t.st_point :lonlat, geographic: true

      t.timestamps
    end
  end
end
