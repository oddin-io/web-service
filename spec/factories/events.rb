# == Schema Information
#
# Table name: events
#
#  id       :integer          not null, primary key
#  code     :string(30)       not null
#  name     :string(100)      not null
#  workload :decimal(7, 2)    default(0.0), not null
#

FactoryBot.define do
  factory :event do
    
  end
end
