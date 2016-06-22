# == Schema Information
#
# Table name: materials
#
#  id       :integer          not null, primary key
#  name     :string(50)       not null
#  mime     :string(50)       not null
#  file_url :text             not null
#

class MaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :mime, :file_url
end
