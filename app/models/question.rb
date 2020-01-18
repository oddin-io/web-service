# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  text            :string(140)      not null
#  anonymous       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  presentation_id :integer          not null
#  person_id       :integer          not null
#

class Question < ApplicationRecord
  TEXT_MAX_LENGTH = 140

  belongs_to :presentation
  belongs_to :person
  has_many :answers
  has_one  :answer, -> { where(accepted: true) }
  has_many :votes, as: :votable
  belongs_to :cluster, optional: true
  belongs_to :presentatio_faq, optional: true
  validates :text, presence: true
  validates :anonymous, exclusion: {in: [nil]}
end
