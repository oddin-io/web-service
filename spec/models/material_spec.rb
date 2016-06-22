require 'rails_helper'

RSpec.describe Material, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:mime) }
  it { is_expected.to validate_presence_of(:file) }

  it { is_expected.to have_and_belong_to_many(:answers) }
  it { is_expected.to have_and_belong_to_many(:instructions) }
  it { is_expected.to have_and_belong_to_many(:presentations) }
end
