require 'rails_helper'

RSpec.describe PresentationsMaterial, type: :model do
  it { is_expected.to belong_to(:presentation) }
  it { is_expected.to belong_to(:material) }
end
