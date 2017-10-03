class TestQuestion < ApplicationRecord
  belongs_to :test
  has_one :file, as: :attachable
end
