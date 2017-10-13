class TestQuestionSerializer < ActiveModel::Serializer
  attributes :id, :number, :description, :answer, :value, :kind, :comment
  has_one :test
end