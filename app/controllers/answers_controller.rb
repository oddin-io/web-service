class AnswersController < ApplicationController
  def index
    render json: current_user.person.answers
  end

  def create
    question = Question.find params[:question_id]
    person = Person.find params[:person_id]

    answer = Question.new text: params[:text], anonymous: params[:anonymous] || false, created_at: DateTime.now,
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
end
