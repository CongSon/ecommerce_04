class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  acts_as_paranoid

  belongs_to :category
  has_many :specifications, dependent: :destroy, inverse_of: :product
  has_many :comments
  has_many :order_details

  ratyrate_rateable "quality"

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

    def import file
      CSV.foreach(file.path, headers: true, col_sep: "|",
        header_converters: :symbol) do |row|
        row = row.to_hash
        specifications_attributes = []
        row[:specifications].split(";").each do |spec|
          spec_hash = Hash.new
          arr_spec = spec.split(",")
          spec_hash[:feature_type] = arr_spec[0]
          spec_hash[:feature_value] = arr_spec[1]
          specifications_attributes.push spec_hash
        end
        row[:specifications_attributes] = specifications_attributes
        row.delete :specifications
        Product.create! row
      end
    end
  end
end
