class TestAnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer
  has_one :person
  has_one :test_question
  has_one :test_alternative
end
