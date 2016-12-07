class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  before_create :set_status_order, :set_bill_code

  def update_order! session_cart, address, phone
    product_carts = session_cart.map {|id, quantity|
      [Product.find_by(id: id), quantity]}
    self.update_attributes total_pay: total_pay(product_carts),
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

  def total_pay product_carts
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
    self[:status] = Settings.open
  end

  def set_bill_code
    self[:bill_code] = Settings.bill << Time.now.strftime(Settings.bill_date)
  end
end
