# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string(140)      not null
#  anonymous   :boolean          default(FALSE), not null
#  accepted    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  question_id :integer          not null
#  person_id   :integer          not null
#

class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text, :anonymous, :created_at, :accepted, :upvotes, :downvotes, :my_vote

  has_one :question
  has_one :person

  def upvotes
    object.votes.where(up: true).count
  end

  def downvotes
    object.votes.where(up: false).count
  end

  def my_vote
    vote = object.votes.where(person: current_user.person).first

    if vote
      vote.up ? 1 : -1
    else
      0
    end
  end
end
