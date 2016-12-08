class ProductsController < ApplicationController
  def index
    @hot_trend_products = Product.hot_trend
    @newest_products = Product.order(created_at: :desc).limit(Settings.product.limit)
  end
end
