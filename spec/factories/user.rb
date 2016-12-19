require "faker"

FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email "exampley@gmail.com"
    password "123456"
  end
  trait :admin do
    role {User.role[:admin]}
 end
end
