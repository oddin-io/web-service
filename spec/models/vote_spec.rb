require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { is_expected.to validate_presence_of(:up) }
  it { is_expected.to validate_presence_of(:person) }
  it { is_expected.to validate_presence_of(:votable) }

  it { is_expected.to belong_to(:person) }
  it { is_expected.to belong_to(:votable) }
end
