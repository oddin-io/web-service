# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(192)      not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SessionSerializer < ActiveModel::Serializer
  attributes :id, :token, :user_id, :created_at

  has_one :person
  has_one :user

  def person
    object.user.person
  end
end
