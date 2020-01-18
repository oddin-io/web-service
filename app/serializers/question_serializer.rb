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
#

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text, :anonymous, :created_at, :upvotes, :my_vote, :answered, :has_answer, :isfaq

  has_one :presentation
  has_one :cluster
  has_one :person

  def upvotes
    object.votes.where(up: true).count
  end

  def my_vote
    vote = object.votes.where(person: current_user).first

    if vote
      vote.up ? 1 : -1
    else
      0
    end
  end

  def has_answer
    !object.answers.size.zero?
  end

  def answered
    !!object.answer
  end

  def person
    return object.person if !object.anonymous

    return Person.new id: 0, name: 'Anônimo', email: 'anonymous@anonymous.com'
  end
end
