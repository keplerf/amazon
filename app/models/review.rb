class Review < ApplicationRecord
  belongs_to :product
  # validates :body , presence: true, uniqueness: {scope: :review_id}
  validates :star, :inclusion => 1..5
end
