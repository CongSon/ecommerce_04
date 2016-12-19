require "rails_helper"
require "admin/products_controller"
require "support/controller_helpers"
require "database_cleaner"

DatabaseCleaner.clean_with :truncation

DatabaseCleaner.strategy = :transaction

RSpec.describe Admin::ProductsController, type: :controller do
  let(:product) {mock_model Product}
  user = FactoryGirl.create :user, role: 0

  describe "GET #index" do
    it "populates an array of products" do
      sign_in user
      product = FactoryGirl.create :product
      get :index
      assigns(:products).should include(product)
    end

    it "renders the index template" do
      sign_in user
      get :index
      expect(response).to render_template("admin/products/index")
    end
  end

  before(:each) do
    request.env["HTTP_REFERER"] = "example_path"
  end
  describe "POST #create" do
    it "create a product successfully" do
      sign_in user
      product_params = FactoryGirl.attributes_for(:product)
      expect{post :create, product: product_params}.to change(Product,:count).by(1)
      expect(flash[:success]).to be_present
      response.should redirect_to "example_path"
    end

    it "create a product fail" do
      sign_in user
      product_params = {name: nil}
      expect{post :create, product: product_params}.to change(Product,:count).by(0)
      expect(flash[:notice]).to be_present
      response.should redirect_to "example_path"
    end
  end

  describe "PUT #update" do
    it "update a product successfully" do
      sign_in user
      product = Product.create! FactoryGirl.attributes_for(:product)
      put :update, id: product.id, product: FactoryGirl.attributes_for(:product)
      expect(flash[:success]).to be_present
      response.should redirect_to "example_path"
    end
    it "update a product fail" do
      sign_in user
      product = Product.create! FactoryGirl.attributes_for(:product)
      product_params = {name: nil}
      put :update, id: product.id, product: product_params
      expect(flash[:notice]).to be_present
      response.should redirect_to "example_path"
    end
  end

  describe "DELETE #destroy" do
    it "delete a product successfully" do
      sign_in user
      product_params = FactoryGirl.attributes_for(:product)
      product = Product.create! product_params
      expect{delete :destroy, id: product.id}.to change(Product,:count).by(-1)
      expect(flash[:success]).to be_present
      response.should redirect_to "example_path"
    end
    it "delete a product fail" do
      sign_in user
      product_params = FactoryGirl.attributes_for(:product)
      product = Product.create! product_params
      Product.any_instance.stub(:destroy).and_return(false)
      expect{delete :destroy, id: product.id}.to change(Product,:count).by(0)
      expect(flash[:danger]).to be_present
      response.should redirect_to "example_path"
    end
  end
end
