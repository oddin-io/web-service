# == Schema Information
#
# Table name: materials
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  type        :string           not null
#  key         :text             not null
#  checked     :boolean          default(FALSE), not null
#  uploaded_at :datetime         not null
#  person_id   :integer          not null
#

class Material < ApplicationRecord
  belongs_to :person

  has_many :presentations_materials
  has_many :presentations, through: :presentations_materials
  has_many :instructions_materials
  has_many :instructions, through:  :instructions_materials
  has_many :answers_materials
  has_many :answers, through: :answers_materials

  validates :person, :key, presence: true
end
