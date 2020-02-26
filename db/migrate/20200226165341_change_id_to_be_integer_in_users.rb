class ChangeIdToBeIntegerInUsers < ActiveRecord::Migration[6.0]
  def change
	change_column :properties, :owner_id, :integer, using:'owner_id::integer'
  end
end
