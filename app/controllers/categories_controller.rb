class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @search = @category.products.search params[:q]
    @products = @search.result.page params[:page]
  end
end
