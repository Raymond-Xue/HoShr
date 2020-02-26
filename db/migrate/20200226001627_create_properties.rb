class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.float :latitude
      t.float :longitude
      t.string :street_address
      t.string :city_id
      t.string :state_id
      t.string :country_id
      t.string :owner_id
      t.integer :n_bedrooms
      t.integer :n_bathrooms
      t.bool :hasKitchen
      t.bool :hasSmokeDetector
      t.bool :hasAirConditioning
      t.string :type_id

      t.timestamps
    end
  end
end
