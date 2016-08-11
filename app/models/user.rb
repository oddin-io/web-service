# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(100)      not null
#  password_digest :string           not null
#

class User < ApplicationRecord
  EMAIL_MAX_LENGTH = 100
  PASSWORD_MIN_LENGTH = 6
  PASSWORD_MAX_LENGTH = 32

  has_secure_password
  has_one :person

  validates :email, :password, presence: true
  validates :email, length: {maximum: self::EMAIL_MAX_LENGTH}
  validates :password, length: {in: self::PASSWORD_MIN_LENGTH..self::PASSWORD_MAX_LENGTH}, allow_nil: true
end
