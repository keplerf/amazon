PRODUCTS_TO_CREATE = 30

PRODUCTS_TO_CREATE.times do
  Product.create title: Faker::Commerce.product_name,
    description: Faker::Hipster.paragraph,
    image: Faker::Avatar.image,
    tbn_image: Faker::Avatar.image,
    category_id: rand(1..Category.count),
    price: rand(100)
end

CATEGORIES_TO_CREATE = 6
CATEGORIES_TO_CREATE.times do
  Category.create title: Faker::Team.name
end

Product.all.each do |x|
 x.update! category_id: rand(1..6)

end

puts Cowsay.say "Created #{PRODUCTS_TO_CREATE} products"
