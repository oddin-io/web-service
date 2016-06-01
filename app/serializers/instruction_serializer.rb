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

class InstructionSerializer < ActiveModel::Serializer
  attributes :id, :class_number, :start_date, :end_date
end
