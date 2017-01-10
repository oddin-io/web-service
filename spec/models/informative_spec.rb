# == Schema Information
#
# Table name: informatives
#
#  id             :integer          not null, primary key
#  text           :string(50)
#  instruction_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Informative, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
