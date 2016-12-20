require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  before(:each) do
    @category = FactoryGirl.create :category
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, id: @category.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :show, id: @category.id
      expect(response).to render_template("show")
    end
  end
end
