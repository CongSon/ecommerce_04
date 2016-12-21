FactoryGirl.define do
  factory :suggested_product do
    name {Faker::Commerce.product_name}
    description {Faker::Lorem.sentence}
    user_id 3
  end
end
