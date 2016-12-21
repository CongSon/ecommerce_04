require "rails_helper"
require "support/controller_helpers"
require "suggested_products_controller"

RSpec.describe SuggestedProductsController, type: :controller do
  before(:each) do
    sign_in FactoryGirl.create(:user)
  end
  describe "GET #new" do
    it "condition to run" do
      get :new
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    it "create a suggested product successfully" do
      suggested_product_params = FactoryGirl.attributes_for(:suggested_product)
      expect{post :create, suggested_product: suggested_product_params}.
        to change(SuggestedProduct,:count).by(1)
      expect(flash[:success]).to be_present
    end

    it "create a suggested product fail" do
      suggested_product_params = {name: nil}
      expect{post :create, suggested_product: suggested_product_params}.
        to change(SuggestedProduct,:count).by(0)
    end
  end

  describe "GET #show" do
    it "assigns the requested suggested_product to @suggested_product" do
      suggested_product = FactoryGirl.create :suggested_product
      get :show, id: suggested_product
      assigns(:suggested_product).should eq(suggested_product)
    end

    it "cannot find suggested product" do
      suggested_product = FactoryGirl.create :suggested_product
      get :show, id: (suggested_product.id + 1)
      expect(flash[:warning]).to be_present
    end

    it "renders the #show view" do
      suggested_product = FactoryGirl.create :suggested_product
      get :show, id: suggested_product
      response.should render_template :show
    end
  end
end
