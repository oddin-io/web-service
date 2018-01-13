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

FactoryBot.define do
  factory :submission do
    work nil
    person nil
  end
end
