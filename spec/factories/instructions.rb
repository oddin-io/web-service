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

FactoryGirl.define do
  factory :instruction do
    class_number {Faker::Number.number 5}
    start_date {Faker::Date.backward 60}
    end_date {Faker::Date.forward 0}
    event
    lecture
  end
end
