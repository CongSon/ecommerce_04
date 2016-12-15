class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do
    redirect_to root_path
  end

  def verify_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    render_404 unless @user
  end

  protected
  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def category_tree categories, left = 0, right = nil, depth = -1
    categories.each do |category|
      if category.lft > left && (right.nil? || category.rgt <
        right) && category.depth == depth + 1
        @categories_tree.push(category)
        categories_temp = categories.compact
        categories_temp.delete category
        if category.rgt != (category.lft + 1)
          category_tree categories_temp, category.lft, category.rgt, category.depth
        end
      end
    end
    @categories_tree
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone])
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.admin?
      admin_charts_path
    else
      root_path
    end
  end
end
