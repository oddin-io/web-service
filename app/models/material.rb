class Material < ActiveRecord::Base
  has_and_belongs_to_many :instructions
  has_and_belongs_to_many :presentations
  has_and_belongs_to_many :answers

  validates :name, :mime, :file, presence: true
end
