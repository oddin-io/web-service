# == Schema Information
#
# Table name: materials
#
#  id         :integer          not null, primary key
#  name       :string(50)       not null
#  type       :text             not null
#  size       :integer          not null
#  url        :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Material, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:size) }
  it { is_expected.to validate_presence_of(:url) }

  it { is_expected.to belong_to(:person) }
  it { is_expected.to have_many(:answers) }
  it { is_expected.to have_many(:instructions) }
  it { is_expected.to have_many(:presentations) }
end
