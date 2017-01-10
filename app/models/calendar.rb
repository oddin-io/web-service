# == Schema Information
#
# Table name: calendars
#
#  id             :integer          not null, primary key
#  text           :string(50)
#  subject        :string(20)
#  date           :datetime
#  instruction_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Calendar < ApplicationRecord
  belongs_to :instruction
  belongs_to :person

  validates :person, :instruction, presence: true
end
