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

require 'test_helper'

class PresentationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
