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
  attributes :id, :class_number, :start_date, :end_date, :profile

  has_one :event
  has_one :lecture

  def profile
    profile = object.enrolls.find_by person: current_user.person

    if profile
      profile.profile
    else
      0
    end
  end
end
