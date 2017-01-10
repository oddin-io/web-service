# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  text       :text
#  work_id    :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubmissionSerializer < ActiveModel::Serializer
  attributes :text, :id, :created_at, :materials

  has_one :work
  has_one :person
end
