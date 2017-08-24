class TestQuestionSerializer < ActiveModel::Serializer
  attributes :id, :number, :question, :answer, :file, :value, :kind
  has_one :test
end
