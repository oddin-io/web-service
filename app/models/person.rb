# == Schema Information
#
# Table name: people
#
#  id      :integer          not null, primary key
#  name    :string(100)      not null
#  user_id :integer          not null
#

class Person < ApplicationRecord
  NAME_MAX_LENGTH = 100

  belongs_to :user
  has_many :questions
  has_many :answers
  has_many :presentations
  has_many :enrolls
  has_many :instructions, through: :enrolls
  has_many :materials

  validates :name, presence: true
  validates :name, length: {maximum: self::NAME_MAX_LENGTH}
end
