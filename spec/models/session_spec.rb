# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(192)      not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Session, type: :model do
  it { is_expected.to validate_length_of(:token).is_at_most(Session::TOKEN_MAX_LENGTH) }
  it { is_expected.to validate_presence_of(:token) }

  it { is_expected.to belong_to(:person) }
end
