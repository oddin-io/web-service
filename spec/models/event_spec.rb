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
  it { is_expected.to have_many(:instructions) }

  context 'is valid' do
    it 'has a valid factory' do
      expect(build(:event)).to be_valid
    end
  end

  context 'is invalid' do
    it 'whitout code' do
      event = build(:event, code: nil)
      event.valid?
      expect(event.errors[:code]).to include('can\'t be blank')
    end

    it 'whitout name' do
      event = build(:event, name: nil)
      event.valid?
      expect(event.errors[:name]).to include('can\'t be blank')
    end
  end
end