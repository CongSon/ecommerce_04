class Order < ApplicationRecord
  before_create :validate!
  belongs_to :user
  has_many :order_details
  before_create :set_status_order, :set_bill_code
  delegate :name, to: :user, prefix: true
  enum status: [:processing, :delivering, :delivered, :cancelled]

  validates :shipping_address, presence: true

  scope :order_in_month, -> (start_date, end_date) do
    where("date(updated_at) > '#{start_date}' AND
      date(updated_at) <'#{end_date}'")
  end

  scope :order_count, -> date_time do
    where("date(created_at) = '#{date_time}'")
  end

  scope :sum_order, -> date_time do
    where("date(created_at) = '#{date_time}'")
  end

  def update_order! session_cart, address, phone
    product_carts = session_cart.map {|id, quantity|
      [Product.find_by(id: id), quantity]}
    self.update_attributes total_pay: calc_total_pay(product_carts),
      shipping_address: address,
      phone: phone
    if self.save
      session_cart.keys.each do |item|
        quantity = session_cart[item].to_i
        order_detail = self.order_details.build
        product_in_order = Product.find_by id: item.to_i
        rest_quantity = product_in_order.quantity - quantity
        product_in_order.update_attributes quantity: rest_quantity
        price = ApplicationController.helpers
          .calc_price_of_order_detail product_in_order, quantity
        order_detail.update quantity:  quantity,
          product_id: item.to_i,
          product_name: product_in_order.name,
          price: price
        order_detail.save
      end
      session_cart.clear
    end
  end

  def validate!
    errors.add(:shipping_address, :blank, message: "cannot be nil") if shipping_address.nil?
  end

  def self.to_xls(options = [])
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |order|
        csv << order.attributes.values_at(*column_names)
      end
    end
  end

  def calc_total_pay product_carts
    each_amount = []
    if product_carts
      product_carts.each do |product, quantity|
        each_amount << ApplicationController.helpers
          .calc_price_of_order_detail(product, quantity)
      end
    end
    total_pay = each_amount.inject(0) {|total_pay, price| total_pay += price}
  end

  private
  def set_status_order
    self[:status] = :processing
  end

  def set_bill_code
    self[:bill_code] = Settings.bill + Time.now.strftime(Settings.bill_date)
  end
end
