class AddOriginGroupToUser < ActiveRecord::Migration[6.0]
  def change
    add_column "users", :origin_group_id, :integer
  end
end
