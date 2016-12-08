class ProductsController < ApplicationController
  before_action :load_product, only: [:show]
  def index
    @hot_trend_products = Product.hot_trend
    @newest_products = Product.order(created_at: :desc).limit(Settings.product.limit)
  end

  def show
    @specifications = @product.specifications
  end

  private
  def load_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash.now[:warning] = t "product.not_found"
      render_404
    end
  end
end
