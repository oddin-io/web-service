# == Schema Information
#
# Table name: presentations
#
#  id             :integer          not null, primary key
#  subject        :string(100)      not null
#  status         :integer          default(0), not null
#  created_at     :datetime         not null
#  instruction_id :integer          not null
#  person_id      :integer          not null
#

FactoryBot.define do
  factory :presentation do
    
  end
end
