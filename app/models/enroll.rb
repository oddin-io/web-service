# == Schema Information
#
# Table name: enrolls
#
#  id             :integer          not null, primary key
#  person_id      :integer          not null
#  instruction_id :integer          not null
#

class Enroll < ActiveRecord::Base
  has_one :person
  has_one :instruction
end
