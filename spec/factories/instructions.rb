# == Schema Information
#
# Table name: instructions
#
#  id         :integer          not null, primary key
#  class      :integer          default(1), not null
#  start_date :date             not null
#  end_date   :date             not null
#  event_id   :integer          not null
#  lecture_id :integer          not null
#

FactoryGirl.define do
  factory :instruction do
    
  end
end
