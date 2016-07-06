# == Schema Information
#
# Table name: lectures
#
#  id       :integer          not null, primary key
#  code     :string(30)       not null
#  name     :string(100)      not null
#  workload :decimal(7, 2)    default(0.0), not null
#

class Lecture < ApplicationRecord
  has_many :instructions

  validates :code, :name, :workload, presence: true
  validates :code, length: {maximum: 30}
  validates :name, length: {maximum: 100}
end
