class AddProprefToRoom < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :rooms, :properties, column: :property_id
  end
end
