# == Schema Information
#
# Table name: lectures
#
#  id       :integer          not null, primary key
#  code     :string(30)       not null
#  name     :string(100)      not null
#  workload :decimal(7, 2)    default(0.0), not null
#

require 'rails_helper'

RSpec.describe Lecture, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:code).is_at_most(Lecture::CODE_MAX_LENGTH) }
  it { is_expected.to validate_length_of(:name).is_at_most(Lecture::NAME_MAX_LENGTH) }

  it { is_expected.to have_many(:instructions) }
end
