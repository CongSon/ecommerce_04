require "faker"

FactoryGirl.define do
  factory :user do |f|
    f.name {Faker::Name.name}
    email  { Faker::Internet.email }
    phone  { Faker::PhoneNumber.phone_number }
    password "123456"
    password_confirmation "123456"
  end
  trait :admin do
    role {User.role[:admin]}
  end
end
