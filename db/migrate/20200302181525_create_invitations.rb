class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.belongs_to :group_from
      t.belongs_to :group_to

      t.timestamps
    end
  end
end
