class Faq < ApplicationRecord
  belongs_to :instruction
  belongs_to :person
end
