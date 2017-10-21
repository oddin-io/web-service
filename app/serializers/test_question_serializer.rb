class TestQuestionSerializer < ActiveModel::Serializer
  attributes :id, :number, :description, :answer, :value, :kind, :comment
  has_one :test
  has_many :test_alternatives
end