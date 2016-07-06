# == Schema Information
#
# Table name: presentations
#
#  id             :integer          not null, primary key
#  subject        :string(100)      not null
#  status         :integer          not null
#  created_at     :datetime         not null
#  instruction_id :integer          not null
#  person_id      :integer          not null
#

class Presentation < ApplicationRecord
  belongs_to :instruction
  belongs_to :person
  has_many :questions
  has_many :presentations_materials
  has_many :materials, through: :presentations_materials

  validates :subject, :status, :created_at, presence: true
  validates :subject, length: {maximum: 100}
end
