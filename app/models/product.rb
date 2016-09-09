class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :price, presence: true#, #numericality: { greater_than: 0, less_than: 1000 }
  validates :description, presence: true

  has_many :favorites , dependent: :destroy
  has_many :users , through: :favorites



  def favorite_for(user)
    favorites.find_by_user_id user
  end

end
