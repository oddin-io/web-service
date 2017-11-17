class TestAnswerSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :answer, :choice, :value, :comment
  has_one :test_response
  has_many :test_question
  has_many :test_alternative
end
