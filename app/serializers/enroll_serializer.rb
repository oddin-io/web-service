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
  attributes :profile

  has_one :person
end
