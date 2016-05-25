# == Schema Information
#
# Table name: people
#
#  id      :integer          not null, primary key
#  name    :string(100)      not null
#  user_id :integer          not null
#

class Person < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :answers
  has_many :presentations
  has_many :enrolls
  has_many :instructions, through: :enrolls

  validates :name, presence: true
  validates :name, length: {maximum: 100}
end
