class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: true, unique: true
      t.string :password_digest

      t.timestamps
    end
    # another way to add index 
    # add_index :users, :email
  end
end
