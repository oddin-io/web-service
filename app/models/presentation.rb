# == Schema Information
#
# Table name: presentations
#
#  id             :integer          not null, primary key
#  subject        :string(30)       not null
#  status         :integer          not null
#  created_at     :datetime         not null
#  instruction_id :integer          not null
#  person_id      :integer          not null
#

class Presentation < ActiveRecord::Base
  has_one :instruction
  has_one :person
end
