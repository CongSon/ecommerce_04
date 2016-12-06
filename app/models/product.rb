class Product < ApplicationRecord
  belongs_to :category
  has_many :specifications
  has_many :comments
  has_many :rates
  has_many :favorites
  has_many :order_details
end
