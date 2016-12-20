FactoryGirl.define do
  factory :category do
    name {Faker::Commerce.product_name}
    description {Faker::Lorem.sentence}
    depth {Faker::Number.number(1)}
    lft {Faker::Number.number(1)}
    rgt {Faker::Number.number(1)}
  end
end
