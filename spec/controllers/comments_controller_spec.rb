require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    sign_in FactoryGirl.create :user
    @comment = FactoryGirl.create :comment
    @product = FactoryGirl.create :product
  end

  describe "POST #create" do
    it "condition to run" do
      post :create, {product_id: @product.slug, comment: {content: "example comment"}}
    end

    it "create comment successfully" do
      expect{post :create, {product_id: @product.slug, comment:
        {content: "example comment"}, format: :html}}.to change(Comment, :count).by(1)
      expect(response.content_type).to eq("text/html")
    end

    it "render 404 when product not found" do
      post :create, {product_id: @product.id, comment:
        {content: "example comment"}, format: :html}
      expect(response).to render_template file: "#{Rails.root}/public/404.html"
    end
  end
end
