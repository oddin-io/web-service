# == Schema Information
#
# Table name: materials
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  type        :string           not null
#  key         :text             not null
#  checked     :boolean          default(FALSE), not null
#  uploaded_at :datetime         not null
#  person_id   :integer          not null
#

class Material < ApplicationRecord
  belongs_to :person
  belongs_to :attachable, polymorphic: true

  validates :person, :key, presence: true
end
