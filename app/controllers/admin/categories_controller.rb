class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :verify_admin
  before_action :load_category_tree, only: [:index, :create]
  layout "admin"

  def index
    @search = Category.search params[:q]
    @categories = @search.result.page params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.update_category params[:parent_id]
      flash[:success] = t ".create_category_success"
    else
      flash[:notice] = t ".create_category_fail"
    end
    redirect_to :back
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".update_success"
    else
      flash[:notice] = t".update_fail"
    end
    redirect_to :back
  end

  def destroy
    if !@category.is_leaf?
      flash[:notice] = t ".must_be_leaf"
    elsif @category.products.any?
      flash[:notice] = t ".notice_message"
    elsif @category.destroy && @category.delete_category
      flash[:success] = t ".delete_success"
    else
      flash[:notice] = t ".delete_fail"
    end
    redirect_to :back
  end
  private
  def category_params
    params.permit :name, :description
  end

  def load_category_tree
    categories = Category.all
    @categories_tree = []
    category_tree categories
  end
end
