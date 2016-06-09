# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(100)      not null
#  password_digest :string           not null
#

FactoryGirl.define do
  factory :user do

  end
end
