class SurveySerializer < ActiveModel::Serializer
  attributes :id, :title, :question
  has_many :alternatives
  has_one :person
end
