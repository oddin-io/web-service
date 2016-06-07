# == Schema Information
#
# Table name: users
#
#  id       :integer          not null, primary key
#  email    :string(100)      not null
#  password :string(16)       not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:email).is_at_most(100) }
  it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(32) }

  it { is_expected.to have_one(:person) }
end
