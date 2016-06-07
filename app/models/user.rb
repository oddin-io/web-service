# == Schema Information
#
# Table name: users
#
#  id       :integer          not null, primary key
#  email    :string(100)      not null
#  password :string(16)       not null
#

class User < ActiveRecord::Base
  has_secure_password
  has_one :person

  validates :email, :password, presence: true
  validates :email, length: {maximum: 100}
  validates :password, length: {in: 8..32}, allow_nil: true
end
