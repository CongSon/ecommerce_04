class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @hot_trend_products = Product.hot_trend
    @newest_products = Product.order(created_at: :desc)
      .limit(Settings.product.limit)
  end

  def show
    @specifications = @product.specifications
  end
end
