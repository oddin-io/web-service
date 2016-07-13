# == Schema Information
#
# Table name: presentations_materials
#
#  id              :integer          not null, primary key
#  presentation_id :integer          not null
#  material_id     :integer          not null
#

require 'rails_helper'

RSpec.describe PresentationsMaterial, type: :model do
  it { is_expected.to belong_to(:presentation) }
  it { is_expected.to belong_to(:material) }
end
