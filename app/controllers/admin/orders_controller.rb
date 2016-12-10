class Admin::OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :verify_admin
  layout "admin"

  def index
    @search = Order.search params[:q]
    @orders = @search.result.page params[:page]
  end

  def update
    unless params[:status].nil?
      if @order.update_attributes status: params[:status].to_i
        flash[:success] = t ".update_success"
      else
        flash[:notice] = t ".update_fail"
      end
      redirect_to admin_orders_path
    end
  end
end
