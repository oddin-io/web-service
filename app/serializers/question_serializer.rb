# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  text            :string(140)      not null
#  anonymous       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  presentation_id :integer
#  person_id       :integer          not null
#

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :anonymous

  has_one :presentation
end
