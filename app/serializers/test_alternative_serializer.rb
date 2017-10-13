class TestAlternativeSerializer < ActiveModel::Serializer
  attributes :id, :text, :correct
  has_one :test_question
end