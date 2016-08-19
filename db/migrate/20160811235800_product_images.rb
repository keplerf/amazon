class ProductImages < ActiveRecord::Migration[5.0]
  def change
      add_column :products, :image, :string
      add_column :products, :tbn_image, :string
  end
end
