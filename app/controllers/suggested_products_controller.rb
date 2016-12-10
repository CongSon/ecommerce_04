class SuggestedProductsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :load_suggested_product, only: :show

  def new
    @suggested_product = SuggestedProduct.new
  end

  def create
    @suggested_product = current_user.suggested_products.build suggested_params
    if @suggested_product.save
      flash[:success] = t ".create_success"
      redirect_to @suggested_product
    else
      render :new
    end
  end

  def show
  end

  private
  def load_suggested_product
    @suggested_product = SuggestedProduct.find_by id: params[:id]
    unless @suggested_product
      flash.now[:warning] = t ".not_found"
      render_404
    end
  end

  def suggested_params
    params.require(:suggested_product).permit :name, :description
  end
end
