class AddUserIdToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :user, :string
    add_reference :products, :user, foreign_key: true
  end

end
