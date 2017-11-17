class TestResponse < ApplicationRecord
  belongs_to :test
  belongs_to :person
  has_many :test_answers, dependent: :destroy
end
