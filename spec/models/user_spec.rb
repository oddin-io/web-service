# == Schema Information
#
# Table name: users
#
#  id       :integer          not null, primary key
#  email    :string(100)      not null
#  password :string(16)       not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
