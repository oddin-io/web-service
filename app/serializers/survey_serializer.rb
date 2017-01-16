class SurveySerializer < ActiveModel::Serializer
  attributes :id, :title, :question, :closed, :created_at, :my_vote
  has_many :alternatives
  has_one :person

  def my_vote
    vote = nil
    object.choices.each do |choice|
      if choice.person == current_user
        vote = choice.alternative.id
        break
      end
    end
    return vote
  end
end
