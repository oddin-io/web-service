class TestResponseSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :score, :closed
  has_one :test
  has_one :person
  has_many :test_answers

  def test_answers
  	object.test_answers.order("id")
  end
end
