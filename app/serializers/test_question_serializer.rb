class TestQuestionSerializer < ActiveModel::Serializer
  attributes :id, :number, :description, :answer, :value, :kind, :attachable_type, :attachable_id
  has_one :test
end
