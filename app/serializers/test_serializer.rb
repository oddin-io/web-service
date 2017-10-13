class TestSerializer < ActiveModel::Serializer
  attributes :id, :title, :date_available, :available_at, :closes_at
  has_one :instruction
  has_one :person
end
