require "rails_helper"
require "support/controller_helpers"
require "database_cleaner"

RSpec.describe Admin::SuggestedProductsController, type: :controller do
  before(:each) do
    sign_in FactoryGirl.create(:user, role: 0)
    @suggested_product = FactoryGirl.create :suggested_product
    @suggested_products = SuggestedProduct.all
  end

  describe "GET #index" do
    it "condition to run" do
      get :index
    end

    it "populates an array of suggested products" do
      get :index
      expect(assigns(:suggested_products)).to include(@suggested_product)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("admin/suggested_products/index")
    end
  end

  describe "PUT #update" do
    it "update a suggested products successfully" do
      params = {status: 1}
      put :update, params.merge(id: @suggested_product.id)
      expect(flash[:success]).to be_present
      response.should redirect_to admin_suggested_products_path
    end

    it "update a suggested products fail" do
      params = {status: 1}
      SuggestedProduct.any_instance.stub(:update_attributes).and_return(false)
      put :update, params.merge(id: @suggested_product.id)
      expect(flash[:notice]).to be_present
      response.should redirect_to admin_suggested_products_path
    end
  end
end
