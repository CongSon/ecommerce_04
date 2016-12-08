class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_session_cart, :load_user, :load_order

  def new
    @product_carts = @session_cart.map {|id, quantity|
      [Product.find_by(id: id), quantity]}
    @total_pay = @order.calc_total_pay @product_carts
  end

  def create
    if @order.update_order! @session_cart,
      params[:address], params[:phone]
      flash[:success] = t ".orders_create_successfully"
      OrderMailer.delay.confirm_order(@order, @user)
    else
      flash[:danger] = t ".orders_create_failed"
    end
    redirect_to root_url
  end

  private
  def load_user
    @user = current_user
    render_404 unless @user
  end

  def load_order
    @order = @user.orders.build
  end
  def load_session_cart
    @session_cart = session[:cart]
    redirect_to root_url if @session_cart.blank?
  end
end
