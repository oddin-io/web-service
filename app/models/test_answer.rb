class TestAnswer < ApplicationRecord
  belongs_to :person
  belongs_to :test_question
  belongs_to :test_alternative
end
