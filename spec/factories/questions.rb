# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  text            :string(140)      not null
#  anonymous       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  presentation_id :integer          not null
#  person_id       :integer          not null
#  answer_id       :integer
#

FactoryGirl.define do
  factory :question do
    
  end
end
