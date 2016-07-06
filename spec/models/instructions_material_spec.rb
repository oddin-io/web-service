require 'rails_helper'

RSpec.describe InstructionsMaterial, type: :model do
  it { is_expected.to belong_to(:instruction) }
  it { is_expected.to belong_to(:material) }
end
