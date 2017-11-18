class TestAnswerSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :response, :choice, :value, :comment
  has_one :test_response
  has_one :test_question
  has_one :test_alternative
end
