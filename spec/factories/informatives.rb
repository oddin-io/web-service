# == Schema Information
#
# Table name: informatives
#
#  id             :integer          not null, primary key
#  text           :string(50)
#  instruction_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :informative do

  end
end
