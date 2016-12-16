class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :load_session_recent_view

  def index
    @hot_trend_products = Product.hot_trend.limit(Settings.product.limit)
    @newest_products = Product.order(created_at: :desc)
      .limit(Settings.product.limit)
    @recent_products = session[:recent].map{|id| Product.find_by(id: id)} if
      session[:recent]
  end

  def show
    session[:recent] = [] unless session[:recent]
    if session[:recent].length >= Settings.max_recent
      session[:recent].delete_at 0
    end
    session[:recent].push @product.id
    @specifications = @product.specifications
    @comments = @product.comments.newest.page params[:page]
  end

  private
  def load_session_recent_view
    @cart = session[:recent] ? session[:recent] : []
  end
end
