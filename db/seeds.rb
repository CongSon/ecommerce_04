# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create! name: "Category1", description: "this is Category1", depth: 0,
  lft: 1, rgt: 2

User.create! email: "n.c.thanh080193@gmail.com", phone: "0123456789", password: "123456",
  password_confirmation: "123456", name: "Nguyen Cong Son", role: 0

Product.create! name: "Apple", description: "apple smartphone", price: 10,
  quantity: 5, category_id: 1
Product.create! name: "Samsung", description: "samsung smartphone", price: 8,
  quantity: 8, category_id: 1
Product.create! name: "Oppo", description: "oppo smartphone", price: 5.5,
  quantity: 6, category_id: 1
Promotion.create! product_id: 1, sale: 0.8, start_date: "2016-12-01",
  end_date: "2016-12-20"
