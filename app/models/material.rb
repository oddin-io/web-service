# == Schema Information
#
# Table name: materials
#
#  id              :integer          not null, primary key
#  name            :string
#  mime            :string
#  key             :text             not null
#  checked         :boolean          default(FALSE)
#  uploaded_at     :datetime
#  attachable_type :string
#  attachable_id   :integer
#  person_id       :integer          not null
#

class Material < ApplicationRecord
  belongs_to :person
  # maybe :cabinet or :locker
  belongs_to :attachable, polymorphic: true

  validates :person, :key, presence: true
end
