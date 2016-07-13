# == Schema Information
#
# Table name: answers_materials
#
#  id          :integer          not null, primary key
#  answer_id   :integer          not null
#  material_id :integer          not null
#

class AnswersMaterial < ApplicationRecord
  belongs_to :answer
  belongs_to :material
end
