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

class Person < ApplicationRecord
  NAME_MAX_LENGTH = 100
  EMAIL_MAX_LENGTH = 100
  PASSWORD_MIN_LENGTH = 6
  PASSWORD_MAX_LENGTH = 32

  has_secure_password

  has_many :questions
  has_many :answers
  has_many :presentations
  has_many :enrolls
  has_many :instructions, through: :enrolls
  has_many :materials
  has_many :surveys
  has_many :choices
  has_many :faqs

  # validates :name, :email, :password, presence: true
  # validates :name, length: {maximum: self::NAME_MAX_LENGTH}
  # validates :email, length: {maximum: self::EMAIL_MAX_LENGTH}
  # validates :password, length: {in: self::PASSWORD_MIN_LENGTH..self::PASSWORD_MAX_LENGTH}, allow_nil: true

  def update_activity
    update online: true, last_activity: Time.now
  end

  def self.update_status
    Person.where('last_activity < ?', Time.now + 15.minutes).update_all(online: false)
  end
end
