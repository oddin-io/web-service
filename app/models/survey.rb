class Survey < ApplicationRecord
  belongs_to :instruction
  belongs_to :person
  has_many :alternatives, dependent: :destroy
  has_many :choices, dependent: :destroy
end
