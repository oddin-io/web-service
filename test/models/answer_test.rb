# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string(140)      not null
#  anonymous   :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  question_id :integer          not null
#  person_id   :integer          not null
#

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
