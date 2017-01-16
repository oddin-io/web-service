class FaqSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer
  has_one :person
end
