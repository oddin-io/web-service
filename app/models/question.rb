# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  text            :string(140)      not null
#  anonymous       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  presentation_id :integer
#  person_id       :integer          not null
#

class Question < ApplicationRecord
  TEXT_MAX_LENGTH = 140

  belongs_to :presentation
  belongs_to :person
  has_many :answers
  has_many :votes, as: :votable

  validates :text, presence: true
  validates :anonymous, exclusion: {in: [nil]}
  validates :text, length: {maximum: self::TEXT_MAX_LENGTH}
end
