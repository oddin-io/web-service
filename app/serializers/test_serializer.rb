class TestSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :date_available, :available_at, :closes_at
  has_one :instruction
  has_one :person
  has_many :test_responses
end
