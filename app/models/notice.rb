# == Schema Information
#
# Table name: notices
#
#  id             :integer          not null, primary key
#  text           :string(100)
#  subject        :string(50)
#  instruction_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Notice < ApplicationRecord
  belongs_to :instruction
  belongs_to :person

  validates :person, :instruction, presence: true
end
