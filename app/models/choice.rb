class Choice < ApplicationRecord
  belongs_to :alternative
  belongs_to :survey
  belongs_to :person
end
