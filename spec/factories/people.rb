# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  name            :string(100)      not null
#  email           :string(100)      not null
#  password_digest :string           not null
#

FactoryGirl.define do
  factory :person do
    
  end
end
