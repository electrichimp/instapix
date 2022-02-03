require "open-uri"

Product.destroy_all
Order.destroy_all

product_0_details = '
  <li>instaBook item</li>
  <li>A second item</li>
  <li>A third item</li>
  <li>A fourth item</li>
  <li>And a fifth one</li>
'
product_1_details = '
  <li>instaFrame item</li>
  <li>A second item</li>
  <li>A third item</li>
  <li>A fourth item</li>
  <li>And a fifth one</li>
'
product_2_details = '
  <li>instaPhotos item</li>
  <li>A second item</li>
  <li>A third item</li>
  <li>A fourth item</li>
  <li>And a fifth one</li>
'

products_params = [
  { name: "instaBook", description: "Es un instabook" ,details: product_0_details,  category: "book", base_price: 30, photo_count: 30 },
  { name: "instaFrame", description: "Es un instaFrame" ,details: product_1_details, category: "frame", base_price: 20, photo_count: 1 },
  { name: "instaPhotos Pack10",description: "Es un instaPhotos" ,details: product_2_details, category: "photo", base_price: 15, photo_count: 15 }
]

# Photos de productos
# Instabook
photo0 = URI.open('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk1-9rEPO4nT7LhDhDdeHuSOIGeh54XNj-vw&usqp=CAU')
photo1 = URI.open('https://www.prestophoto.com/storage/static/landing/photos-iphoto-aperture-book-printing/apple-photo-book-template.jpg')
photo2 = URI.open('https://cdn.shopify.com/s/files/1/1107/8092/products/12x16_Padded_Book-small_1024x1024.jpg?v=1571452366')
photo3 = URI.open('https://cdn2.chrzz.com/contents/assets/detail_images-k87di9rddgsa1truqg7xkqrdjgaj-1x-1.jpg')

product_0_photos = [photo0, photo1, photo2, photo3]

# instaFrame
photo11 = URI.open('https://secure.img1-fg.wfcdn.com/im/47328520/resize-h310-w310%5Ecompr-r85/9706/97062522/5-piece-tymoteusz-picture-frame-set-set-of-5.jpg')
photo12 = URI.open('https://pyxis.nymag.com/v1/imgs/7c2/c2a/91c77a2633f8910db163bc4301fd1666b6.rsquare.w600.jpg')
photo13 = URI.open('https://akimages.shoplocal.com/dyn_li/412.0.90.0/Retailers/michaels/220130IA_Pg1_7989_1.jpg')
photo14 = URI.open('https://pyxis.nymag.com/v1/imgs/590/3f7/04394acab9b92c2ba481cb87a31876ed60-digital-picture-frame-lede.2x.rsocial.w600.jpg')

product_1_photos = [photo11, photo12, photo13, photo14]

# instaPhotos
photo20 = URI.open('https://blog.hootsuite.com/wp-content/uploads/2017/12/social-media-image-tools.jpg')
photo21 = URI.open('https://images.unsplash.com/photo-1500051638674-ff996a0ec29e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=918&q=80')
photo22 = URI.open('https://images.unsplash.com/photo-1531844806351-6f135a39b0a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80')
photo23 = URI.open('https://www.socialprintstudio.com/img/products/mini-photo-prints/slider-2/mini-prints-7.jpg')

product_2_photos = [photo21, photo22, photo23, photo20]
# Fin Photos de productos

# Creando productos
# Instabook
product_0 = Product.create(products_params[0])
product_0.photo.attach(io: product_0_photos[0], filename: "main_photo.png", content_type: 'image/png')
product_0.photos.attach(io: product_0_photos[1], filename: "main_photo.png", content_type: 'image/png')
product_0.photos.attach(io: product_0_photos[2], filename: "photo1.png", content_type: 'image/png')
product_0.photos.attach(io: product_0_photos[3], filename: "photo2.png", content_type: 'image/png')
product_0.save

# instaPhotos
product_1 = Product.create(products_params[1])
product_1.photo.attach(io: product_1_photos[0], filename: "main_photo.png", content_type: 'image/png')
product_1.photos.attach(io: product_1_photos[1], filename: "main_photo.png", content_type: 'image/png')
product_1.photos.attach(io: product_1_photos[2], filename: "photo1.png", content_type: 'image/png')
product_1.photos.attach(io: product_1_photos[3], filename: "photo2.png", content_type: 'image/png')
product_1.save


# instaFrame
product_2 = Product.create(products_params[2])
product_2.photo.attach(io: product_2_photos[0], filename: "main_photo.png", content_type: 'image/png')
product_2.photos.attach(io: product_2_photos[1], filename: "main_photo.png", content_type: 'image/png')
product_2.photos.attach(io: product_2_photos[2], filename: "photo1.png", content_type: 'image/png')
product_2.photos.attach(io: product_2_photos[3], filename: "photo2.png", content_type: 'image/png')
product_2.save

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
