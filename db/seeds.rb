
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = %w(tv mobile tablet ac refridgerator)

(1..5).each do |i|
  category = Category.create(description: categories[i - 1])

  total = rand(100..200)
  products = []
  (1..total).each do |i|
    name = (0...8).map { (65 + rand(26)).chr }.join + i.to_s
    price = rand(500.0...1000.0).round(2)

    products << {name: name, price: price, category_id: category.id, created_at: Time.now, updated_at: Time.now}
  end

  Product.upsert_all(products)
end


users = [
  {
    name: 'Bachan',
    email: 'bachan37@gmail.com'
  },
  {
    name: 'rishabh',
    email: 'rishabh@gmail.com'
  },
  {
    name: 'unmesh',
    email: 'unmesh@gmail.com'
  },
  {
    name: 'suman',
    email: 'suman@gmail.com'
  },
  {
    name: 'shon',
    email: 'shon@gmail.com'
  },
  {
    name: 'goel',
    email: 'goel@gmail.com'
  },
  {
    name: 'sumangoel',
    email: 'sumangoel@gmail.com'
  }
]

data = []

users.each do |user_data|
  data << user_data.merge!(password: 'mindfire', created_at: Time.now, updated_at: Time.now)
end

User.upsert_all(data)
