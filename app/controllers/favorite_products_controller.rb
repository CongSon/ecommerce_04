class FavoriteProductsController < ApplicationController
  before_action :authenticate_user!, :load_product

  def create
    Favorite.create favorited: @product, user: current_user if @favorite.nil?
  end

  def destroy
    @favorite.destroy unless @favorite.nil?
  end

  private
  def load_product
    @product = Product.find_by id: params["product_id"].to_i
    render_404 unless @product
    @favorite = Favorite.find_by favorited_id: @product.id,
      user_id: current_user.id
  end
end
