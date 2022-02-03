# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Order.destroy_all

products = [
  { name: "instaBook", category: "book", base_price: 30, photo_count: 30 },
  { name: "instaFrame", category: "frame", base_price: 20, photo_count: 1 },
  { name: "instaPhotos Pack10", category: "photo", base_price: 15, photo_count: 15 }
]

products.each do |product|
  Product.create(product)
end

user = User.create(
    first_name: "Luis",
    last_name: "Augusto",
    billing_address: "Jose Perez 234, Miraflores",
    email: "luis@gmail.com",
    password: '12345678',
    password_confirmation: '12345678'
  )

orders = [
  { shipping_address: "Lizardo Montero 450, Miraflores", user: user, state: "pending", total_price: 30, purchase_date: Date.today},
  { shipping_address: "Pedro Venturo 425, Surco", user: user, state: "pending", total_price: 20, purchase_date: Date.today}
]

orders.each do |order|
  Order.create(order)
end

prints = [
  { title: "mi perfil", order_id: 1,
    product_id: 2, quantity: 1, purchase_price: 20 },
  { title: "mi familia", order_id: 1,
    product_id: 2, quantity: 1, purchase_price: 20 },
  { title: "mi libro 1", order_id: 2,
    product_id: 1, quantity: 1, purchase_price: 30 },
  { title: "mi familia 2", order_id: 2,
    product_id: 2, quantity: 1, purchase_price: 20 }
]

prints.each do |print|
  Print.create(print)
end
