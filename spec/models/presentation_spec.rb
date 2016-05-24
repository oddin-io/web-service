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

require 'rails_helper'

RSpec.describe Presentation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
