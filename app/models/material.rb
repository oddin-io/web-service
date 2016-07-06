# == Schema Information
#
# Table name: materials
#
#  id         :integer          not null, primary key
#  name       :string(50)       not null
#  type       :text             not null
#  size       :integer          not null
#  url        :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Material < ApplicationRecord
  belongs_to :person

  has_many :presentations_materials
  has_many :presentations, through: :presentations_materials
  has_many :instructions_materials
  has_many :instructions, through:  :instructions_materials
  has_many :answers_materials
  has_many :answers, through: :answers_materials

  validates :name, :type, :size, :url, :updated_at, presence: true
end
