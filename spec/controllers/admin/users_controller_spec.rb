require "rails_helper"
require "support/controller_helpers"

RSpec.describe Admin::UsersController, type: :controller do
  let(:user) {mock_model User}
  admin = FactoryGirl.create :user, role: 0

  describe "GET #index" do
    it "populates an array of users" do
      sign_in admin
      user = FactoryGirl.create :user
      users = User.all
      get :index
      expect(users).to include(user)
    end

    it "renders the index template" do
      sign_in admin
      get :index
      expect(response).to render_template("admin/users/index")
    end
  end

  before(:each) do
    request.env["HTTP_REFERER"] = "example_path"
  end

  describe "DELETE #destroy" do
    it "delete a user successfully" do
      sign_in admin
      user = FactoryGirl.create :user
      expect{delete :destroy, id: user.id}.to change(User,:count).by(-1)
      expect(flash[:success]).to be_present
      response.should redirect_to "example_path"
    end
    it "delete a user fail" do
      sign_in admin
      user = FactoryGirl.create :user
      User.any_instance.stub(:destroy).and_return(false)
      expect{delete :destroy, id: user.id}.to change(User,:count).by(0)
      expect(flash[:danger]).to be_present
      response.should redirect_to "example_path"
    end
  end
end


