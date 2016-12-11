class SuggestedProduct < ApplicationRecord
  belongs_to :user
  validates :name, presence: :true
  before_create :set_status_suggested

  enum status: [:processing, :accepted, :rejected]

  private
  def set_status_suggested
    self[:status] = :processing
  end
end
