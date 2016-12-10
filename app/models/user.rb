class User < ApplicationRecord
  has_many :comments
  has_many :rates
  has_many :favorites
  has_many :orders
  has_many :suggested_products
  before_save :init_role

  acts_as_paranoid

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  paginates_per Settings.user.per_page

  enum role: [:admin, :user]

  scope :all_users, -> search {where QUERY_BY_NAME_OR_EMAIL,
    search: "%#{search}%"}
  QUERY_BY_NAME_OR_EMAIL = "name like :search or email like :search"
  scope :email_admin, -> () {
    self.select(:id, :email).where role: :admin
  }
  class << self
    def find_all_user
      User.select(:id, :name, :email, :avatar).where(role: :user)
        .order created_at: :DESC
    end
  end

  private
  def init_role
    self.role ||= :user
  end
end
