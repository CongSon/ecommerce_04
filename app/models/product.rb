class Product < ApplicationRecord
  belongs_to :category
  has_many :specifications, dependent: :destroy, inverse_of: :product
  has_many :comments
  has_many :rates
  has_many :favorites
  has_many :order_details

  paginates_per 10
  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
  validates :price, presence: true, length: {minimum: 10}
  validates :quantity, presence: true, length: {minimum: 6}
  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :specifications, allow_destroy: true,
    reject_if: proc{|attributes| attributes["feature_value"].blank?}
  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  class << self
    def list_product
      self.order(created_at: :ASC).includes(:category)
    end
  end
end
