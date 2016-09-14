# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  text       :text
#  work_id    :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Submission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
