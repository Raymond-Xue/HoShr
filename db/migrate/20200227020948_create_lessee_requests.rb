class CreateLesseeRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :lessee_requests do |t|
      t.float :latitude
      t.float :longitude
      t.float :radius
      t.integer :city_id
      t.integer :state_id
      t.integer :country_id
      t.integer :lessee_id
      t.date :earliest_movein_date
      t.date :latest_movein_date
      t.integer :min_duration
      t.integer :max_duration
      t.integer :duration_unit
      t.float :max_rent
      t.integer :max_rent_unit
      t.integer :max_rent_currency
      t.integer :max_n_roommates
      t.integer :max_n_housemates
      t.boolean :private_bath
      t.boolean :balcony
      t.boolean :smoke
      t.string :roommate_gender

      t.timestamps
    end
  end
end
