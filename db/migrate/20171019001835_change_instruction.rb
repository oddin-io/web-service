class ChangeInstruction < ActiveRecord::Migration[5.0]
	class Instruction < ApplicationRecord
	  belongs_to :event
	  belongs_to :lecture
	  has_many :presentations
	  has_many :enrolls
	  has_many :people, through: :enrolls
	  has_many :materials, as: :attachable
	  has_many :notices
	  has_many :calendars
	  has_many :surveys
	  has_many :tests
	  has_many :faqs

	  validates :class_code, :start_date, :end_date, presence: true
	  validates :class_code, uniqueness: {scope: [:lecture, :event]}
	end
end
