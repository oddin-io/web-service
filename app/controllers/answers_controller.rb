class AnswersController < ApplicationController
  def index
    render json: Answer.all
  end

  def new
    render plain: 'I display a form for creating new entity'
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

  def edit
    render plain: 'I display a form for editing an entity'
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end
end
