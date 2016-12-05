class User < ApplicationRecord
  has_many :comments
  has_many :rates
  has_many :favorites
  has_many :orders
  has_many :suggested_products

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
end
