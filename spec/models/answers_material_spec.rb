# == Schema Information
#
# Table name: answers_materials
#
#  id          :integer          not null, primary key
#  answer_id   :integer          not null
#  material_id :integer          not null
#

require 'rails_helper'

RSpec.describe AnswersMaterial, type: :model do
  it { is_expected.to belong_to(:answer) }
  it { is_expected.to belong_to(:material) }
end
