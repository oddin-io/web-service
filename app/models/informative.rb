class Informative < ApplicationRecord
  belongs_to :instruction
  belongs_to :person

  validates :person, :instruction, presence: true
end
