class TestQuestion < ApplicationRecord
  belongs_to :test
  has_one :file, as: :attachable
  has_many :test_alternatives, dependent: :destroy
end