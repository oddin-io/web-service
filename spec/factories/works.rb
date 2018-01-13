# == Schema Information
#
# Table name: works
#
#  id             :integer          not null, primary key
#  subject        :text             not null
#  description    :text             not null
#  deadline       :datetime         not null
#  instruction_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :work do
    instruction ""
    person ""
  end
end
