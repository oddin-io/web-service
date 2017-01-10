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

class Submission < ApplicationRecord
  belongs_to :work
  belongs_to :person

  has_many :materials, as: :attachable
end
