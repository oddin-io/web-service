# == Schema Information
#
# Table name: materials
#
#  id       :integer          not null, primary key
#  name     :string(50)       not null
#  mime     :string(50)       not null
#  file_url :text             not null
#

require 'rails_helper'

RSpec.describe Material, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:mime) }
  it { is_expected.to validate_presence_of(:file_url) }

  it { is_expected.to have_and_belong_to_many(:answers) }
  it { is_expected.to have_and_belong_to_many(:instructions) }
  it { is_expected.to have_and_belong_to_many(:presentations) }
end
