require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.create :user}

  it ".email_admin" do
    user = FactoryGirl.create :user, role: :admin
    (User.email_admin).should include(user)
  end

  it ".user_count" do
    user = FactoryGirl.create :user
    (User.user_count(Date.today)).should include(user)
  end

  context "columns" do
    it {expect have_db_column(:email).of_type(:string)}
    it {expect have_db_column(:name).of_type(:string)}
    it {expect have_db_column(:encrypted_password).of_type(:string)}
    it {expect have_db_column(:phone).of_type(:string)}
    it {expect have_db_column(:avatar).of_type(:string)}
  end
  context "relationship" do
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :orders}
    it {is_expected.to have_many :suggested_products}
    it {is_expected.to have_many :favorites}
  end

  context "validates" do
    it {expect validate_presence_of :name}
    it {expect validate_presence_of(:email)}
    it {expect validate_length_of(:encrypted_password)}
  end

  describe "instance methods" do
    it {expect respond_to(:init_role)}
    it {expect respond_to(:find_all_user)}
  end

  describe "find_all_user" do
    it "user_all" do
      user = FactoryGirl.create :user
      users = User.find_all_user
      expect(users).to include user
    end
  end

  auth_hash = OmniAuth::AuthHash.new({
    provider: "facebook",
    uid: "1234",
    info: {
      email: "user@example.com",
      name: "Justin Bieber"
    }
  })
  describe ".from_omniauth" do
    it "retrieves an existing user" do
      user = User.new(
        provider: "facebook",
        uid: 1234,
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
        )
      user.save
      omniauth_user = User.from_omniauth(auth_hash)
      expect(user).to eq(omniauth_user)
    end

    it "creates a new user if one doesn't already exist" do
      expect{User.from_omniauth(auth_hash)}.to change(User, :count).by 1
    end
  end
end
