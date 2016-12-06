# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create! name: "Category1", description: "this is Category1"

User.create! email: "admin@gmail.com", password: "123456", password_confirmation: "123456"

Product.create! name: "Apple", price: 10, quantity: 5, category_id: 1
Product.create! name: "Samsung", price: 8, quantity: 8, category_id: 1
Product.create! name: "Oppo", price: 5, quantity: 6, category_id: 1
