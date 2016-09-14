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

require 'rails_helper'

RSpec.describe Work, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
