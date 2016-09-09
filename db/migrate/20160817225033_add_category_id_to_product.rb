class AddCategoryIdToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :category_id, :integer
    add_foreign_key :products, :categories
    # change_column :products, :part_number, :text
    #  rename_column :users, :email, :email_address
  end
end
