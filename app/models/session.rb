# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(192)      not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ApplicationRecord
  TOKEN_MAX_LENGTH = 192

  belongs_to :person

  validates :token, length: {maximum: self::TOKEN_MAX_LENGTH}, presence: true
end
