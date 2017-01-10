# == Schema Information
#
# Table name: enrolls
#
#  id             :integer          not null, primary key
#  profile        :integer          not null
#  person_id      :integer          not null
#  instruction_id :integer          not null
#

class EnrollSerializer < ActiveModel::Serializer
  attributes :id, :profile

  has_one :instruction
  has_one :person
end
