# == Schema Information
#
# Table name: people
#
#  id      :integer          not null, primary key
#  name    :string(100)      not null
#  user_id :integer          not null
#

require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(Person::NAME_MAX_LENGTH) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:enrolls) }
  it { is_expected.to have_many(:instructions) }
  it { is_expected.to have_many(:presentations) }
  it { is_expected.to have_many(:questions) }
  it { is_expected.to have_many(:answers) }
  it { is_expected.to have_many(:materials) }
end
