class RedefineToken < ApplicationRecord
  belongs_to :person

  validates :person, :token, presence: true
end
