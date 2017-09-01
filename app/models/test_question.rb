class TestQuestion < ApplicationRecord
  belongs_to :test
  belongs_to :attachable, polymorphic: true
end
