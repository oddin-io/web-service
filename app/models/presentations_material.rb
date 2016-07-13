# == Schema Information
#
# Table name: presentations_materials
#
#  id              :integer          not null, primary key
#  presentation_id :integer          not null
#  material_id     :integer          not null
#

class PresentationsMaterial < ApplicationRecord
  belongs_to :presentation
  belongs_to :material
end
