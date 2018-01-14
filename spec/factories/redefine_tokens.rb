# == Schema Information
#
# Table name: redefine_tokens
#
#  id         :integer          not null, primary key
#  token      :string(192)      not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :redefine_token do

  end
end
