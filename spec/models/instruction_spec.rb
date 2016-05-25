# == Schema Information
#
# Table name: instructions
#
#  id           :integer          not null, primary key
#  class_number :integer          default(1), not null
#  start_date   :date             not null
#  end_date     :date             not null
#  event_id     :integer          not null
#  lecture_id   :integer          not null
#

require 'rails_helper'

RSpec.describe Instruction, type: :model do
  it { is_expected.to validate_presence_of(:class_number) }
  it { is_expected.to validate_presence_of(:start_date) }
  it { is_expected.to validate_presence_of(:end_date) }
  it { is_expected.to validate_numericality_of(:class_number).only_integer }

  it { is_expected.to belong_to(:event) }
  it { is_expected.to belong_to(:lecture) }
  it { is_expected.to have_many(:enrolls) }
  it { is_expected.to have_many(:people) }
end
