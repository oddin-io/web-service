# == Schema Information
#
# Table name: events
#
#  id       :integer          not null, primary key
#  code     :string(30)       not null
#  name     :string(100)      not null
#  workload :decimal(7, 2)    default(0.0), not null
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:code).is_at_most(30) }
  it { is_expected.to validate_length_of(:name).is_at_most(100) }

  it { is_expected.to have_many(:instructions) }

  context 'is valid' do
    it 'has a valid factory' do
      expect(build(:event)).to be_valid
    end
  end

  context 'is invalid' do
    it 'without code' do
      event = build(:event, code: nil)
      expect(event.valid?).to be false
    end

    it 'without name' do
      event = build(:event, name: nil)
      expect(event.valid?).to be_falsy
    end
  end
end