# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(192)      not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :session do
    
  end
end
