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
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_presence_of(:anonymous) }
  it { is_expected.to validate_presence_of(:created_at) }
  it { is_expected.to validate_length_of(:text).is_at_most(140) }

  it { is_expected.to belong_to(:presentation) }
  it { is_expected.to belong_to(:person) }
  it { is_expected.to have_many(:answers) }
end
