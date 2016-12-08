class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

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
end
