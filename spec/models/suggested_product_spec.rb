require "rails_helper"

RSpec.describe SuggestedProduct, type: :model do
  describe "suggested product db schema" do
    context "column" do
      it {should have_db_column(:name).of_type(:string)}
      it {should have_db_column(:description).of_type(:text)}
      it {should have_db_column(:status).of_type(:integer)}
      it {should have_db_column(:user_id).of_type(:integer)}
    end
  end

  describe "validate internal model" do
    subject {FactoryGirl.create :suggested_product}
    context "association" do
      it {is_expected.to belong_to :user}
    end

    context "validates" do
      it {expect validate_presence_of :name}
    end
  end
end
