# == Schema Information
#
# Table name: users
#
#  id       :integer          not null, primary key
#  email    :string(100)      not null
#  password :string(16)       not null
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
end
