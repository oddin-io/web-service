# == Schema Information
#
# Table name: instructions_materials
#
#  id             :integer          not null, primary key
#  instruction_id :integer          not null
#  material_id    :integer          not null
#

class InstructionsMaterial < ApplicationRecord
  belongs_to :instruction
  belongs_to :material
end
