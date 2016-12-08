class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!, :load_all_categories
  layout "admin"

  def index
    @product = Product.new
    @products = Product.list_product.in_category(params[:category_id])
      .page params[:page]
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".create_product_success"
    else
      flash[:notice] = t ".create_product_fail"
    end
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit :category_id, :name, :description,
      :price, :image, :quantity,
      specifications_attributes: [:id, :feature_value, :feature_type, :_destroy]
  end

  def load_all_categories
    @categories = Category.all
  end
end
