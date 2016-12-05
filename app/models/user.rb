class User < ApplicationRecord
  has_many :comments, :rates, :favorites, :orders, :suggested_products
end
