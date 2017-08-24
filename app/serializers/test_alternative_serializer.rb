class TestAlternativeSerializer < ActiveModel::Serializer
  attributes :id, :answer, :correct
  has_one :person
  has_one :test
  has_one :test_question
end
