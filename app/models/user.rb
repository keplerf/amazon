class User < ApplicationRecord
  has_secure_password
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :likes, dependent: :nullify
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
            unless:     :from_oauth?

  serialize :twitter_data, Hash

  has_many :favorites, dependent: :destroy
  has_many :favorite_products , through: :favorites, source: :product

  has_many :likes, dependent: :destroy
  has_many :liked_reviews , through: :likes, source: :reviews

  def from_oauth?
    self.uid.present? && provider.present?
  end

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end

  def self.find_or_create_from_twitter(twitter_data)
      find_by_twitter(twitter_data) || create_from_twitter(twitter_data)
  end

  def self.find_by_twitter(twitter_data)
    find_by(uid: twitter_data["uid"], provider: twitter_data["provider"])
  end

  def from_twitter?
    self.uid.present? && provider == "twitter"
 end

 def self.create_from_twitter(twitter_data)
     full_name = twitter_data["info"]["name"].split
     create!(first_name:       full_name[0],
            last_name:        full_name[1],
            uid:              twitter_data["uid"],
            provider:         twitter_data["provider"],
            twitter_token:    twitter_data["credentials"]["token"],
            twitter_secret:   twitter_data["credentials"]["secret"],
            password:         SecureRandom.hex(32),
            twitter_raw_data: twitter_data)
   end

   private

   def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(32)
      break unless User.find_by_api_key(self.api_key)
    end
  end
end
