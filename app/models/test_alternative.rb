class TestAlternative < ApplicationRecord
  belongs_to :person
  belongs_to :test
  belongs_to :test_question
end
