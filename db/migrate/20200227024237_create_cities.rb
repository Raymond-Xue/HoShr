class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :city_name
      t.integer :state_id
      t.integer :country_id
      t.float :max_latitude
      t.float :min_latitude
      t.float :max_longitude
      t.float :min_longitude

      t.timestamps
    end
  end
end
