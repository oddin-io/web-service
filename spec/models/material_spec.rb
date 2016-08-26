# == Schema Information
#
# Table name: materials
#
#  id              :integer          not null, primary key
#  name            :string
#  mime            :string
#  key             :text             not null
#  checked         :boolean          default(FALSE)
#  uploaded_at     :datetime
#  attachable_type :string
#  attachable_id   :integer
#  person_id       :integer          not null
#

require 'rails_helper'

RSpec.describe Material, type: :model do
  it { is_expected.to validate_presence_of(:key) }
  it { is_expected.to validate_presence_of(:person) }

  it { is_expected.to belong_to(:person) }
  it { is_expected.to belong_to(:attachable) }
end
