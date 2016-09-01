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
#

require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_most(Person::EMAIL_MAX_LENGTH) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(Person::PASSWORD_MIN_LENGTH).
      is_at_most(Person::PASSWORD_MAX_LENGTH) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(Person::NAME_MAX_LENGTH) }

  it { is_expected.to have_many(:enrolls) }
  it { is_expected.to have_many(:instructions) }
  it { is_expected.to have_many(:presentations) }
  it { is_expected.to have_many(:questions) }
  it { is_expected.to have_many(:answers) }
  it { is_expected.to have_many(:materials) }
end
