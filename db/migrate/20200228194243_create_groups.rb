class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.integer :group_id
      t.integer :n_lessees

      t.timestamps
    end
  end
end
