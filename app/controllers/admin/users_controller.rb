class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :verify_admin
  before_action :load_user, only: :destroy
  layout "admin"

  def index
    params[:search] ||= ""
    @users = User.find_all_user
      .all_users(params[:search])
      .page params[:page]
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".fail_to_delete"
    end
    redirect_to :back
  end
end
