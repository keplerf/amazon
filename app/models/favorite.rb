class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, uniqueness: {scope: :product_id, message: "Product already favorited !"}
end
