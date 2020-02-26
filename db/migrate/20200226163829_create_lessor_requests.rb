class CreateLessorRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :lessor_requests do |t|
      t.integer :property_id
      t.date :earliest_movein_date
      t.integer :min_duration
      t.float :total_rent
      t.string :total_rent_currency

      t.timestamps
    end
  end
end
