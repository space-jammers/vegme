class Feedback < ApplicationRecord
  belongs_to :user
  validates :label, :message, :user_id, presence: true
  validates :link, format: { with: /\A.*vegme.*\Z/ }
end
