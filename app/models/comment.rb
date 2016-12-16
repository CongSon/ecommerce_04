class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  paginates_per Settings.comment.per_page
  class << self
    def newest
      Comment.order(created_at: :desc)
    end
  end
end
