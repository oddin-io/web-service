# == Schema Information
#
# Table name: instructions_materials
#
#  id             :integer          not null, primary key
#  instruction_id :integer          not null
#  material_id    :integer          not null
#

require 'rails_helper'

RSpec.describe InstructionsMaterial, type: :model do
  it { is_expected.to belong_to(:instruction) }
  it { is_expected.to belong_to(:material) }
end
