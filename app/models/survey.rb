class Survey < ApplicationRecord
  belongs_to :instruction
  belongs_to :person
  has_many :alternatives
  has_many :choices
end
