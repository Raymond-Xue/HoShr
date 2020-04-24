class AddActiveForMatchingToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :active_for_matching, :boolean, default: true
  end
end
