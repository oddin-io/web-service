class TestAnswer < ApplicationRecord
  belongs_to :test_response
  belongs_to :test_question
  belongs_to :test_alternative, optional: true
end
