# == Schema Information
#
# Table name: materials
#
#  id              :integer          not null, primary key
#  name            :string
#  mime            :string
#  key             :text             not null
#  checked         :boolean          default(FALSE)
#  uploaded_at     :datetime
#  attachable_type :string
#  attachable_id   :integer
#  person_id       :integer          not null
#

FactoryGirl.define do
  factory :material do
    
  end
end
