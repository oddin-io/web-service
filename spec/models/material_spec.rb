# == Schema Information
#
# Table name: materials
#
#  id                :integer          not null, primary key
#  file_file_name    :string           not null
#  file_content_type :string           not null
#  file_file_size    :integer          not null
#  file_updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Material, type: :model do
  it { is_expected.to have_attached_file(:upload) }
  it { is_expected.to validate_attachment_presence(:upload) }

  it { is_expected.to belong_to(:person) }
  it { is_expected.to have_and_belong_to_many(:answers) }
  it { is_expected.to have_and_belong_to_many(:instructions) }
  it { is_expected.to have_and_belong_to_many(:presentations) }
end
