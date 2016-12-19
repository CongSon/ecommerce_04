require "rails_helper"
require "products_controller"

RSpec.describe ProductsController, type: :controller do
  let(:product) {mock_model Product}

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "display recent product" do
      product = FactoryGirl.create :product
      get :show, id: product.id
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      product = FactoryGirl.create :product
      get :show, id: product.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns the requested product to @product" do
      product = FactoryGirl.create :product
      get :show, id: product.id
      assigns(:product).should eq(product)
    end

    it "renders the index template" do
      product = FactoryGirl.create :product
      get :show, id: product.id
      expect(response).to render_template("show")
    end

    it "delete first recent product in queue" do
      (Settings.max_recent + 1).times do
        product = FactoryGirl.create :product
        get :show, id: product.id
      end
      expect(response).to render_template("show")
    end
  end
end
