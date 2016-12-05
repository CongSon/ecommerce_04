class Product < ApplicationRecord
  belongs_to :category
  has_many :specifications, :comments, :rates, :favorites, :order_details
end
