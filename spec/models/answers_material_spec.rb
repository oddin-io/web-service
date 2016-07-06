require 'rails_helper'

RSpec.describe AnswersMaterial, type: :model do
  it { is_expected.to belong_to(:answer) }
  it { is_expected.to belong_to(:material) }
end
