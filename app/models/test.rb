class Test < ApplicationRecord
  belongs_to :instruction
  belongs_to :person
  has_many :test_questions, dependent: :destroy
end
