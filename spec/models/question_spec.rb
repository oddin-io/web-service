# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  text            :string(140)      not null
#  anonymous       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  presentation_id :integer          not null
#  person_id       :integer          not null
#  answer_id       :integer
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_length_of(:text).is_at_most(Question::TEXT_MAX_LENGTH) }
  it { is_expected.to validate_exclusion_of(:anonymous).in_array([nil]) }

  it { is_expected.to belong_to(:presentation) }
  it { is_expected.to belong_to(:person) }
  it { is_expected.to have_many(:answers) }
  it { is_expected.to have_many(:votes) }
end
