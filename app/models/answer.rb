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

class Answer < ApplicationRecord
  TEXT_MAX_LENGTH = 140

  belongs_to :question
  belongs_to :person
  has_many :materials, as: :attachable
  has_many :votes, as: :votable

  validates :text, :created_at, presence: true
  validates :anonymous, exclusion: {in: [nil]}
  validates :text, length: {maximum: self::TEXT_MAX_LENGTH}
end
