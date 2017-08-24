class TestSerializer < ActiveModel::Serializer
  attributes :id, :title, :available_at
  has_one :instruction
  has_one :person
end
