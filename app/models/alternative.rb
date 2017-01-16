class Alternative < ApplicationRecord
  belongs_to :survey
  has_many :choices, dependent: :destroy

  def choice_count
    self.choices.count
  end
end
