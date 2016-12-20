require "rails_helper"
require "support/controller_helpers"
require "database_cleaner"

RSpec.describe Admin::CategoriesController, type: :controller do
  before(:each) do
    sign_in FactoryGirl.create(:user, role: 0)
    @category = FactoryGirl.create :category
    request.env["HTTP_REFERER"] = "example_path"
  end

  describe "GET #index" do
    it "populates an array of categories" do
      get :index
      assigns(:categories).should include(@category)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("admin/categories/index")
    end
  end

  describe "POST #create" do
    it "create a category with parent successfully" do
      expect{post :create, {name: "category sample", parent_id: @category.id}}.
        to change(Category,:count).by(1)
      expect(flash[:success]).to be_present
      response.should redirect_to "example_path"
    end

    it "create a category without parent successfully" do
      expect{post :create, {name: "category sample", parent_id: ""}}.
        to change(Category,:count).by(1)
      expect(flash[:success]).to be_present
      response.should redirect_to "example_path"
    end

    it "create a category fail" do
      expect{post :create, {name: nil, parent_id: @category.id}}.to change(
        Category,:count).by(0)
      expect(flash[:notice]).to be_present
      response.should redirect_to "example_path"
    end
  end

  describe "PUT #update" do
    it "update a category successfully" do
      category_params = FactoryGirl.attributes_for(:category)
      put :update, category_params.merge(id: @category.id)
      expect(flash[:success]).to be_present
      response.should redirect_to "example_path"
    end

    it "update a category fail" do
      category_params = {name: nil}
      put :update, category_params.merge(id: @category.id)
      expect(flash[:notice]).to be_present
      response.should redirect_to "example_path"
    end
  end

  describe "DELETE #destroy" do
    it "delete fail because category is not leaf" do
      category_params = FactoryGirl.attributes_for(:category)
      params = category_params.clone
      params[:rgt] = category_params[:lft].to_i + 2
      category = Category.create params

      expect{delete :destroy, id: category.id}.to change(Category,:count).by(0)
      expect(flash[:notice]).to be_present
      response.should redirect_to "example_path"
    end

    it "delete fail because category contains product" do
      category_params = FactoryGirl.attributes_for(:category)
      category_params[:rgt] = category_params[:lft].to_i + 1
      category = Category.create category_params

      product_params = FactoryGirl.attributes_for(:product)
      product_params[:category_id] = category.id
      Product.create product_params

      expect{delete :destroy, id: category.id}.to change(Category,:count).by(0)
      expect(flash[:notice]).to be_present
      response.should redirect_to "example_path"
    end

    it "delete fail cause .destroy return false" do
      category_params = FactoryGirl.attributes_for(:category)
      params = category_params.clone
      params[:rgt] = category_params[:lft].to_i + 1
      category = Category.create params

      Category.any_instance.stub(:destroy).and_return(false)
      expect{delete :destroy, id: category.id}.to change(Category,:count).by(0)
      expect(flash[:notice]).to be_present
      response.should redirect_to "example_path"
    end

    it "delete category successfully" do
      category_params = FactoryGirl.attributes_for(:category)
      category_params[:rgt] = category_params[:lft].to_i + 1
      category = Category.create category_params

      expect{delete :destroy, id: category.id}.to change(Category,:count).by(-1)
      expect(flash[:success]).to be_present
      response.should redirect_to "example_path"
    end
  end
end
