class Admin::CsvController < ApplicationController
  before_action :authenticate_user!, :verify_admin

  def create
    Product.import params[:file]
    redirect_to :back, notice: t(".product_imported")
  end
end
