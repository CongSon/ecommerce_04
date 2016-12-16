class Admin::SuggestedProductsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :verify_admin
  layout "admin"

  def index
    @search = SuggestedProduct.search params[:q]
    @suggested_products = @search.result.order(created_at: :DESC).page params[:page]
  end

  def update
    unless params[:status].nil?
      if @suggested_product.update_attributes status: params[:status].to_i
        flash[:success] = t ".update_success"
      else
        flash[:notice] = t ".update_fail"
      end
      redirect_to admin_suggested_products_path
    end
  end
end
