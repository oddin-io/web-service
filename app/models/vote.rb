class Vote < ApplicationRecord
  belongs_to :person
  belongs_to :votable, polymorphic: true

  validates :up, :person, :votable, presence: true
end
