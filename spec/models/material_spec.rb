require 'rails_helper'

RSpec.describe Material, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:mime) }
  it { is_expected.to validate_presence_of(:file) }
end
