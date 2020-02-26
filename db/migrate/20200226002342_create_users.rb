class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :email
      t.string :gender
      t.string :occupation
      t.integer :age

      t.timestamps
    end
  end
end
