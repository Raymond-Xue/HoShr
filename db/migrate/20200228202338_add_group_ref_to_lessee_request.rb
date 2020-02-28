class AddGroupRefToLesseeRequest < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :lessee_requests, :groups, column: :group_id
  end
end
