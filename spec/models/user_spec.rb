# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(100)      not null
#  password_digest :string           not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:email).is_at_most(User::EMAIL_MAX_LENGTH) }
  it { is_expected.to validate_length_of(:password).is_at_least(User::PASSWORD_MIN_LENGTH).
      is_at_most(User::PASSWORD_MAX_LENGTH) }

  it { is_expected.to have_one(:person) }
end
