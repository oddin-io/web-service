# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string(140)      not null
#  anonymous   :boolean          default(FALSE), not null
#  accepted    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  question_id :integer          not null
#  person_id   :integer          not null
#

FactoryBot.define do
  factory :answer do
    
  end
end
