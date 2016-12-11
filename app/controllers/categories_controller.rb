class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @products = @category.products.page params[:page]
  end
end
