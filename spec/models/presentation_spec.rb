# == Schema Information
#
# Table name: presentations
#
#  id             :integer          not null, primary key
#  subject        :string(100)      not null
#  status         :integer          default(0), not null
#  created_at     :datetime         not null
#  instruction_id :integer          not null
#  person_id      :integer          not null
#

require 'rails_helper'

RSpec.describe Presentation, type: :model do
  it { is_expected.to validate_presence_of(:subject) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_length_of(:subject).is_at_most(Presentation::SUBJECT_MAX_LENGTH) }

  it { is_expected.to belong_to(:person) }
  it { is_expected.to belong_to(:instruction) }
  it { is_expected.to have_many(:questions) }
  it { is_expected.to have_many(:materials) }
end
