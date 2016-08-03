# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string(140)      not null
#  anonymous   :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  question_id :integer          not null
#  person_id   :integer          not null
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_length_of(:text).is_at_most(Answer::TEXT_MAX_LENGTH) }
  it { is_expected.to validate_exclusion_of(:anonymous).in_array([nil]) }

  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:person) }
  it { is_expected.to have_many(:materials) }
  it { is_expected.to have_many(:votes) }
end
