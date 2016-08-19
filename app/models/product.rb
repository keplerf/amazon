class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :price, presence: true#, #numericality: { greater_than: 0, less_than: 1000 }
  validates :description, presence: true

end
