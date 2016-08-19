FactoryGirl.define do
  factory :product do
    sequence(:title)  {|n| Faker::StarWars.character  + n.to_s  }
    description       {    Faker::ChuckNorris.fact     }
    price             { 1 + rand(100) }
    image             { Faker::Avatar.image }
    tbn_image         { Faker::Avatar.image }
  end
end
