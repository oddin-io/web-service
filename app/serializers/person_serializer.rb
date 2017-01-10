# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  name            :string(100)      not null
#  email           :string(100)      not null
#  password_digest :string           not null
#  online          :boolean          default(FALSE)
#  last_activity   :datetime
#  admin           :boolean
#

class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :online, :admin
end
