require "common"
class Admin::ChartsController < ApplicationController
  include SharedMethods
  layout "admin"
  def index
    @user_accounts = []
    @orders = []
    get_chart_data
    respond_to do |format|
      format.html
      format.json {
        render json: [
          {type: I18n.t("column"), name: I18n.t("users"),
            data: @user_accounts,
            tooltip: {valueSuffix: I18n.t("users")}},
          {type: I18n.t("column"), name: I18n.t("order"),
            data: @orders,
            tooltip: {valueSuffix: I18n.t("order")}}
        ]
      }
    end
  end

  private
  def get_chart_data
    current_date = get_current_monday - Settings.one.day
    Settings.weekday.times.each do |day|
      @user_accounts << User.user_count(current_date
        .strftime(Settings.date_format)).count
      @orders << Order.order_count(current_date
        .strftime(Settings.date_format)).count
      current_date = current_date - Settings.one.day
    end
    @user_accounts.reverse!
    @orders.reverse!
  end
end
