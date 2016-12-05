class Admin::CategoriesController < ApplicationController
  before_action :load_all_categories
  def index
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

  private
  def category_params
    params.permit :name, :description
  end

  def load_all_categories
    @categories = Category.all
  end
end
