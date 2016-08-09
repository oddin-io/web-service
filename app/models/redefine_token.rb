class RedefineToken < ApplicationRecord
  belongs_to :user

  validates :user, :token, presence: true
end
