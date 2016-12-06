class Product < ApplicationRecord
  belongs_to :category
  has_many :specifications, dependent: :destroy, inverse_of: :product
  has_many :comments
  has_many :rates
  has_many :favorites
  has_many :order_details

  validates :content, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
  validates :price, presence: true, length: {minimum: 10}
  validates :quantity, presence: true, length: {minimum: 6}

  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :specifications, allow_destroy: true,
    reject_if: proc{|attributes| attributes["feature_value"].blank?}
end
