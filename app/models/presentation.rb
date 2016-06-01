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

class Presentation < ActiveRecord::Base
  belongs_to :instruction
  belongs_to :person
  has_many :questions

  validates :subject, :status, :created_at, presence: true
  validates :subject, length: {maximum: 100}
end
