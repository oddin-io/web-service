class TestAnswer < ApplicationRecord
  belongs_to :test_response
  has_many :test_questions, dependent: :destroy
  has_many :test_alternatives, dependent: :destroy
end
