class AnswersController < ApplicationController
  def index
    render json: current_user.person.answers
  end

  def create
    question = Question.find params[:question_id]
    person = current_user.person
    answer = Answer.new text: params[:text], anonymous: params[:anonymous] || false, created_at: DateTime.now,
                            question: question, person: person
    answer.save!
    render json: answer
  end

  def show
    render json: Answer.find(params[:id])
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end

  def upvote
    vote = Vote.find_or_create_by(person: current_user.person, votable: Answer.find(params[:id]))
    vote.up = true
    vote.save!

    render json: vote
  end

  def downvote
    vote = Vote.find_or_create_by(person: current_user.person, votable: Answer.find(params[:id]))
    vote.up = false
    vote.save!

    render json: vote
  end

  def vote
    Vote.find(person: current_user.person, votable: Answer.find(params[:id])).delete

    render status: 200, nothing: true
  end
end
