class AddGroupIdToLesseeRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :lessee_requests, :group_id, :integer
	remove_column :users, :group_id
  end
end
