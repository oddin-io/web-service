# == Schema Information
#
# Table name: notices
#
#  id             :integer          not null, primary key
#  text           :string(100)
#  subject        :string(50)
#  instruction_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :notice do
    text "MyString"
    instruction ""
    person ""
  end
end
