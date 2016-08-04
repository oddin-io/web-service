# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  text            :string(140)      not null
#  anonymous       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  presentation_id :integer          not null
#  person_id       :integer          not null
#  answer_id       :integer
#

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text, :anonymous, :created_at, :upvotes, :downvotes, :my_vote

  has_one :presentation
  has_one :person
  has_many :answers
  has_one :answer

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
