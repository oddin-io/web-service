require 'rails_helper'

RSpec.describe RedefineToken, type: :model do
  it { is_expected.to validate_presence_of(:person) }
  it { is_expected.to validate_presence_of(:token) }

  it { is_expected.to belong_to(:person) }
end
