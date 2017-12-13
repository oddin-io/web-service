class RequestSerializer < ActiveModel::Serializer
  attributes :id, :status, :created_at
  has_one :person
  has_one :presentation
end
