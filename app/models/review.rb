class Review < ApplicationRecord
  belongs_to :product
  # validates :body , presence: true, uniqueness: {scope: :review_id}
  validates :star, :inclusion => 1..5

  has_many :likes , dependent: :destroy
  has_many :users , through: :likes
end
