# == Schema Information
#
# Table name: works
#
#  id             :integer          not null, primary key
#  subject        :text             not null
#  description    :text             not null
#  deadline       :datetime         not null
#  instruction_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Work < ApplicationRecord
  belongs_to :instruction
  belongs_to :person
  has_many :materials, as: :attachable

  validates :subject, :description, presence: true
end
