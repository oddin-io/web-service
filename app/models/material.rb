class Material < ActiveRecord::Base
  validates :name, :mime, :file, presence: true
end
