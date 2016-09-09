class User < ApplicationRecord
  has_secure_password
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :likes, dependent: :nullify
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


  has_many :favorites, dependent: :destroy
  has_many :favorite_products , through: :favorites, source: :product

  has_many :likes, dependent: :destroy
  has_many :liked_reviews , through: :likes, source: :reviews

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end
end
