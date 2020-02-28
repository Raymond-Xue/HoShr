class AddForeignKeys < ActiveRecord::Migration[6.0]
  def change
  	add_foreign_key :properties, :users, column: :owner_id
	change_column :properties, :city_id, :integer, using:'city_id::integer' 
	add_foreign_key :properties, :cities, column: :city_id
	add_foreign_key :cities, :states, column: :state_id
	add_foreign_key :states, :countries, column: :country_id
	add_foreign_key :lessor_requests, :properties, column: :property_id
	add_foreign_key :lessee_requests, :users, column: :lessee_id
	
  end
end
