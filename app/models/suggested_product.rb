class SuggestedProduct < ApplicationRecord
  belongs_to :user
  belongs_to :category
end
