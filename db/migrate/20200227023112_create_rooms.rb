class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms, :id => false do |t|
      t.integer :room_id
      t.integer :property_id
      t.float :area
      t.integer :area_unit
      t.boolean :hasBalcony
      t.boolean :hasPrivateBath
      t.boolean :status

      t.timestamps
    end
  end
end
