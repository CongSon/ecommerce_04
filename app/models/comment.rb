class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  class << self
    def newest
      Comment.order(created_at: :desc)
    end
  end
end
