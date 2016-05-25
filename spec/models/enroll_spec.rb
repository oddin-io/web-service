# == Schema Information
#
# Table name: enrolls
#
#  id             :integer          not null, primary key
#  profile        :integer          not null
#  person_id      :integer          not null
#  instruction_id :integer          not null
#

require 'rails_helper'

RSpec.describe Enroll, type: :model do
  it { is_expected.to validate_presence_of(:profile) }

  it { is_expected.to belong_to(:person) }
  it { is_expected.to belong_to(:instruction) }
end
