class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :country_name
      t.float :max_latitude
      t.float :min_latitude
      t.float :max_longitude
      t.float :min_longitude

      t.timestamps
    end
  end
end
