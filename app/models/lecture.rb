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
  CODE_MAX_LENGTH = 30
  NAME_MAX_LENGTH = 100

  has_many :instructions

  validates :code, :name, :workload, presence: true
  validates :code, length: {maximum: self::CODE_MAX_LENGTH}
  validates :name, length: {maximum: self::NAME_MAX_LENGTH}
end
