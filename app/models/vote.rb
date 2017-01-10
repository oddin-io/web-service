# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  up           :boolean          default(TRUE), not null
#  person_id    :integer          not null
#  votable_type :string           not null
#  votable_id   :integer          not null
#

class Vote < ApplicationRecord
  belongs_to :person
  belongs_to :votable, polymorphic: true

  validates :person, :votable, presence: true
  validates :up, exclusion: [nil]
end
