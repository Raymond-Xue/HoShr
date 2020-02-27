class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.string :state_name
      t.integer :country_id
      t.float :max_latitude
      t.float :min_latitude
      t.float :max_longitude
      t.float :min_longitude

      t.timestamps
    end
  end
end
