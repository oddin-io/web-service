# == Schema Information
#
# Table name: enrolls
#
#  id             :integer          not null, primary key
#  profile        :integer          not null
#  person_id      :integer          not null
#  instruction_id :integer          not null
#

class Enroll < ApplicationRecord
  belongs_to :person
  belongs_to :instruction

  validates :profile, presence: true
end
