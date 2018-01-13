# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  up           :boolean          default(TRUE), not null
#  person_id    :integer          not null
#  votable_type :string           not null
#  votable_id   :integer          not null
#

FactoryBot.define do
  factory :vote do
    
  end
end
