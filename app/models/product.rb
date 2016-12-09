class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  acts_as_paranoid

  belongs_to :category
  has_many :specifications, dependent: :destroy, inverse_of: :product
  has_many :comments
  has_many :rates
  has_many :favorites
  has_many :order_details

  delegate :name, to: :category, prefix: true

  paginates_per Settings.product.per_page
  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
  validates :price, presence: true, numericality: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :specifications, allow_destroy: true,
    reject_if: proc{|attributes| attributes["feature_value"].blank?}
  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  class << self
    def list_product
      self.order(created_at: :ASC).includes(:category)
    end

    def hot_trend
      product_ids = "select order_details.product_id
       from order_details
       where (julianday('now') - julianday(order_details.created_at)) < 5
       group by order_details.product_id
       order by sum(order_details.quantity)"
     Product.where("id IN (#{product_ids})")
   end
  end
end
