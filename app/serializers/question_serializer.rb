# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  text            :string(140)      not null
#  anonymous       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  presentation_id :integer          not null
#  person_id       :integer          not null
#  answer_id       :integer
#

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text, :anonymous, :created_at

  has_one :presentation
  has_one :person
  has_many :answers
  has_one :answer
end
