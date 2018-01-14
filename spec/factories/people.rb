# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  name            :string(100)      not null
#  email           :string(100)      not null
#  password_digest :string           not null
#  online          :boolean          default(FALSE)
#  last_activity   :datetime
#  admin           :boolean
#

FactoryBot.define do
  factory :person do
    name Faker::Name.name
    email Faker::Internet.email
    password Faker::Internet.password(8)
  end
end
