# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create! email: "n.c.thanh080193@gmail.com", phone: "0123456789", password: "123456",
  password_confirmation: "123456", name: "Nguyen Chi Thanh", role: 0
User.create! email: "sonncse03032@gmail.com", phone: "0123456789", password: "123456",
  password_confirmation: "123456", name: "Nguyen Cong Son", role: 0

2.times do |n|
  name  = "Nguyen Van Tuan #{n+1}"
  phone = "0123456789"
  email = "example-#{n+1}@gmail.com"
  password = "123456"
  password_confirmation = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    phone: phone,
    created_at: "2016-12-05 00:0#{n}:00",
    updated_at: "2016-12-05 00:0#{n}:00")
end

5.times do |n|
  name  = "Nguyen Thi Linh #{n+1}"
  phone = "0123456789"
  email = "example-#{n+3}@gmail.com"
  password = "123456"
  password_confirmation = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    phone: phone,
    created_at: "2016-12-06 00:0#{n}:00",
    updated_at: "2016-12-06 00:0#{n}:00")
end

4.times do |n|
  name  = "Tran Van Thinh #{n+1}"
  phone = "0123456789"
  email = "example-#{n+8}@gmail.com"
  password = "123456"
  password_confirmation = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    phone: phone,
    created_at: "2016-12-07 00:0#{n}:00",
    updated_at: "2016-12-07 00:0#{n}:00")
end

7.times do |n|
  name  = "Ho Viet Tuan #{n+1}"
  phone = "0123456789"
  email = "example-#{n+12}@gmail.com"
  password = "123456"
  password_confirmation = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    phone: phone,
    created_at: "2016-12-08 00:0#{n}:00",
    updated_at: "2016-12-08 00:0#{n}:00")
end

3.times do |n|
  name  = "Duong Thi Van #{n+1}"
  phone = "0123456789"
  email = "example-#{n+19}@gmail.com"
  password = "123456"
  password_confirmation = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    phone: phone,
    created_at: "2016-12-09 00:0#{n}:00",
    updated_at: "2016-12-09 00:0#{n}:00")
end
2.times do |n|
  name  = "Nguyen Binh Hai #{n+1}"
  phone = "0123456789"
  email = "example-#{n+22}@gmail.com"
  password = "123456"
  password_confirmation = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    phone: phone,
    created_at: "2016-12-10 00:0#{n}:00",
    updated_at: "2016-12-10 00:0#{n}:00")
end

5.times do |n|
  name  = "Cao Thi Tuyet #{n+1}"
  phone = "0123456789"
  email = "example-#{n+24}@gmail.com"
  password = "123456"
  password_confirmation = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    phone: phone,
    created_at: "2016-12-11 00:0#{n}:00",
    updated_at: "2016-12-11 00:0#{n}:00")
end

Category.create name: "Apple", description: "This is apple smartphone", depth: 0,
  lft: 1, rgt: 6
Category.create name: "iPhone 6/7", description: "This is iPhone 6/7", depth: 1,
  lft: 2, rgt: 3
Category.create name: "iPhone 4/5", description: "This is iPhone 4/5", depth: 1,
  lft: 4, rgt: 5
Category.create name: "Android", description: "This is android smartphone", depth: 0,
  lft: 7, rgt: 18
Category.create name: "Samsung", description: "This is samsung smartphone", depth: 1,
  lft: 8, rgt: 9
Category.create name: "Sony", description: "This is sony smartphone", depth: 1,
  lft: 10, rgt: 11
Category.create name: "Lg", description: "This is lg smartphone", depth: 1,
  lft: 12, rgt: 13
Category.create name: "Xiaomi", description: "This is xiaomi smartphone", depth: 1,
  lft: 14, rgt: 15
Category.create name: "Oppo", description: "This is oppo smartphone", depth: 1,
  lft: 16, rgt: 17

Product.create name: "Iphone 6", description: "Apple's product. That's terrific",
  quantity: 20, price: 499, category_id: 2
Product.create name: "Iphone 6S", description: "Apple's product. That's terrific",
  quantity: 20, price: 549, category_id: 2
Product.create name: "Iphone 7", description: "Apple's product. That's terrific",
  quantity: 20, price: 599, category_id: 2
Product.create name: "Iphone 7s", description: "Apple's product. That's terrific",
  quantity: 20, price: 649, category_id: 2

Product.create name: "Iphone 4", description: "Apple's product. That's terrific",
  quantity: 20, price: 399, category_id: 3
Product.create name: "Iphone 4S", description: "Apple's product. That's terrific",
  quantity: 20, price: 449, category_id: 3
Product.create name: "Iphone 5", description: "Apple's product. That's terrific",
  quantity: 20, price: 499, category_id: 3
Product.create name: "Iphone 5s", description: "Apple's product. That's terrific",
  quantity: 20, price: 449, category_id: 3
Product.create name: "Iphone 5SE", description: "Apple's product. That's terrific",
  quantity: 20, price: 549, category_id: 3

10.times do |n|
  name = "Samsung Galaxy S#{n+1}"
  description = "Samsung's product. That's terrific"
  quantity = 15 + n
  price = 379
  Product.create(
    name: name,
    description: description,
    quantity: quantity,
    price: price,
    category_id: 5
  )
end

8.times do |n|
  name = "Sony Xperia X#{n+1}"
  description = "Sony's product. That's terrific"
  quantity = 15 + n
  price = 449
  Product.create(
    name: name,
    description: description,
    quantity: quantity,
    price: price,
    category_id: 6
  )
end

6.times do |n|
  name = "Lg Optimus L#{n+1}"
  description = "LG's product. That's terrific"
  quantity = 15 + n
  price = 349
  Product.create(
    name: name,
    description: description,
    quantity: quantity,
    price: price,
    category_id: 7
  )
end

4.times do |n|
  name = "Xiaomi Mi#{n+1}"
  description = "Xiaomi's product. That's terrific"
  quantity = 15 + n
  price = 299
  Product.create(
    name: name,
    description: description,
    quantity: quantity,
    price: price,
    category_id: 8
  )
end

8.times do |n|
  name = "Oppo F#{n+1}s"
  description = "Oppo's product. That's terrific"
  quantity = 15 + n
  price = 299
  Product.create(
    name: name,
    description: description,
    quantity: quantity,
    price: price,
    category_id: 9
  )
end

45.times do |n|
  Specification.create feature_type: "Screen", feature_value: "5 inches", product_id: (n+1)
  Specification.create feature_type: "Camera", feature_value: "13 MP", product_id: (n+1)
  Specification.create feature_type: "Storage", feature_value: "64 GB", product_id: (n+1)
  Specification.create feature_type: "Battery", feature_value: "3400 mAh", product_id: (n+1)
end

7.times do |m|
  Random.rand(4).times do |n|
    Order.create total_pay: (m + 3) * 50, user_id: 3, shipping_address: "VietNam",
      phone: "0123456789", created_at: "2016-12-#{5+m} 00:1#{n}:00", updated_at: "2016-12-#{5+m} 00:1#{n+1}:00"
  end
  Random.rand(4).times do |n|
    Order.create total_pay: (m + 3) * 50, user_id: 4, shipping_address: "VietNam",
      phone: "0123456789", created_at: "2016-12-#{5+m} 00:1#{n}:00", updated_at: "2016-12-#{5+m} 00:1#{n+1}:00"
  end
end
