class AddGroupIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :group_id, :integer
	remove_column :groups, :group_id
  end
end
