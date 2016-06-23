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

class MaterialSerializer < ActiveModel::Serializer
  attribute :id
  attribute :file_file_name, key: :name
  attribute :file_content_type, key: :mime
  attribute :file_file_size, key: :size
  attribute :file_updated_at, key: :updated_at
end
