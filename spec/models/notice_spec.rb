# == Schema Information
#
# Table name: notices
#
#  id             :integer          not null, primary key
#  text           :string(140)
#  instruction_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Notice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
