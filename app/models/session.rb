class Session < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :remember_digest, presence: true
end
