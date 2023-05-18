# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# ADMIN
User.create(
  role: User.roles[:admin],
  full_name: Faker::Name.name,
  email: 'admin@example.com',
  password: '12345678'
)

# BASIC
User.create(
  role: User.roles[:basic],
  full_name: Faker::Name.name,
  email: 'basic@example.com',
  password: '12345678'
)

10.times do
  User.create(
    role: User.roles[:admin],
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '12345678'
  )

  User.create(
    role: User.roles[:basic],
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '12345678'
  )

  Client.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address
  )
end

20.times do
  Category.create(
    creator: User.admin.sample,
    name: Faker::Lorem.unique.word.capitalize,
    description: Faker::Lorem.paragraph
  )
end

categories = Category.all
image_path = Rails.root.join('db/resources/images/product.svg')

20.times do
  product = Product.create(
    creator: User.admin.sample,
    name: Faker::Commerce.unique.product_name,
    description: Faker::Lorem.paragraph,
    categories: categories.sample(rand(1..4)),
    price: Faker::Commerce.price(range: 100..1000.0)
  )
  product.images.attach(io: File.open(image_path), filename: 'product')
end

products = Product.all
clients = Client.all

100.times do
  Purchase.create(
    client: clients.sample,
    product: products.sample,
    quantity: rand(1..10),
    skip_first_purchase_email: true
  )
end

puts 'Seeds loaded successfully'
