# == Schema Information
#
# Table name: materials
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  type        :string           not null
#  key         :text             not null
#  checked     :boolean          default(FALSE), not null
#  uploaded_at :datetime         not null
#  person_id   :integer          not null
#

require 'rails_helper'

RSpec.describe Material, type: :model do
  it { is_expected.to validate_presence_of(:key) }
  it { is_expected.to validate_presence_of(:person) }

  it { is_expected.to belong_to(:person) }
  it { is_expected.to belong_to(:attachable) }
end
