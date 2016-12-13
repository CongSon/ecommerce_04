require "common"
class User < ApplicationRecord
  include SharedMethods
  has_many :comments
  has_many :orders
  has_many :suggested_products
  has_many :favorites
  has_many :favorite_products, through: :favorites, source: :favorited,
    source_type: "Product"
  before_save :init_role

  ratyrate_rater

  acts_as_paranoid

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  paginates_per Settings.user.per_page

  enum role: [:admin, :user]

  scope :all_users, -> search {where QUERY_BY_NAME_OR_EMAIL,
    search: "%#{search}%"}
  QUERY_BY_NAME_OR_EMAIL = "name like :search or email like :search"
  scope :email_admin, -> () {
    self.select(:id, :email).where role: :admin
  }

  scope :user_count, -> date_time do
    where("date(created_at) = '#{date_time}'")
  end

  class << self
    def find_all_user
      User.select(:id, :name, :email, :avatar).where(role: :user)
        .order created_at: :DESC
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.phone = auth.info.phone
        user.avatar = auth.info.image + "?type=large"
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.save
      end
    end
  end

  private
  def init_role
    self.role ||= :user
  end
end
