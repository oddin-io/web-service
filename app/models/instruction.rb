# == Schema Information
#
# Table name: instructions
#
#  id           :integer          not null, primary key
#  class_number :integer          default(1), not null
#  start_date   :date             not null
#  end_date     :date             not null
#  event_id     :integer          not null
#  lecture_id   :integer          not null
#

class Instruction < ApplicationRecord
  belongs_to :event
  belongs_to :lecture
  has_many :presentations
  has_many :enrolls
  has_many :people, through: :enrolls
  has_many :instructions_materials
  has_many :materials, through: :instructions_materials

  validates :class_number, :start_date, :end_date, presence: true
  validates :class_number, numericality: {only_integer: true}
end
