class Category < ApplicationRecord
  has_many :suggested_products, :products
end
