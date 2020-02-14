class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :firstname
      t.string :middlename
      t.string :lastname

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
