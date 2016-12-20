require "rails_helper"

RSpec.describe Category, type: :model do
  describe "Category db schema" do
    context "column" do
      it {should have_db_column(:name).of_type(:string)}
      it {should have_db_column(:description).of_type(:text)}
      it {should have_db_column(:depth).of_type(:integer)}
      it {should have_db_column(:lft).of_type(:integer)}
      it {should have_db_column(:rgt).of_type(:integer)}
    end
  end

  describe "validate internal model" do
    subject {FactoryGirl.create :category}
    context "association" do
      it {is_expected.to have_many :products}
    end

    context "validates" do
      it {expect validate_presence_of :name}
      it {expect validate_uniqueness_of(:name).allow_blank}
    end
  end
end
