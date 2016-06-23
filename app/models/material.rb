# == Schema Information
#
# Table name: materials
#
#  id                :integer          not null, primary key
#  file_file_name    :string           not null
#  file_content_type :string           not null
#  file_file_size    :integer          not null
#  file_updated_at   :datetime         not null
#

class Material < ActiveRecord::Base
  has_attached_file :file

  has_and_belongs_to_many :instructions
  has_and_belongs_to_many :presentations
  has_and_belongs_to_many :answers

  validates_attachment_content_type :file, content_type: /\Aapplication\/octet-stream\Z/
  validates_attachment_presence :file
end
