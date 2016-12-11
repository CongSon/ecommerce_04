class Admin::ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :load_all_leaf_categories
  layout "admin"

  def index
    @product = Product.new
    @search = Product.search params[:q]
    @products = @search.result.page params[:page]
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

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t ".update_success"
    else
      flash[:notice] = t ".update_failed"
    end
    redirect_to :back
  end

  def destroy
    if @product.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".fail_to_delete"
    end
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit :category_id, :name, :description,
      :price, :image, :quantity,
      specifications_attributes: [:id, :feature_value, :feature_type, :_destroy]
  end

  def load_all_leaf_categories
    @categories_leaf = Category.all.reject {|category| !category.is_leaf?}
  end
end
