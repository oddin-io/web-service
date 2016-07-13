class QuestionsController < ApplicationController
  def index
    render json: current_user.person.questions
  end

  def create
    presentation = Presentation.find params[:presentation_id]
    person = Person.find params[:person_id]
    question = Question.new text: params[:text], anonymous: params[:anonymous] || false, created_at: DateTime.now,
                            presentation: presentation, person: person
    question.save!
    render json: question
  end

  def show
    render plain: 'I show one entity'
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end
end
