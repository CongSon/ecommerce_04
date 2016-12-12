class RaterController < ApplicationController

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      if obj.nil?
        render json: false
      else
        obj.rate params[:score].to_f, current_user, params[:dimension]
        render json: true
      end
    else
      render json: false
    end
  end
end
