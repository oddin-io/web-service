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

class Question < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :person
  has_many :answers

  validates :text, :created_at, presence: true
  validates :anonymous, exclusion: {in: [nil]}
  validates :text, length: {maximum: 140}
end
