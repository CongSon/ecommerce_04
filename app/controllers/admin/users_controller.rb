class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :verify_admin
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
