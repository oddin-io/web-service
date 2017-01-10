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

class CalendarSerializer < ActiveModel::Serializer
  attributes :id, :text, :subject, :date, :created_at

  has_one :instruction
  has_one :person
end
