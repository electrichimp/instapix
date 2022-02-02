# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all

products = [
  { name: "instaBook", category: "book", base_price: 30, photo_count: 30 },
  { name: "instaFrame", category: "frame", base_price: 20, photo_count: 1 }
]

products.each do |product|
  Product.create(product)
end
