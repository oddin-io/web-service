# == Schema Information
#
# Table name: people
#
#  id      :integer          not null, primary key
#  name    :string(100)      not null
#  user_id :integer          not null
#

class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_one :user
end
