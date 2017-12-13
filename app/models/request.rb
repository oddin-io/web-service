class Request < ApplicationRecord
  belongs_to :presentation
  belongs_to :person
end
