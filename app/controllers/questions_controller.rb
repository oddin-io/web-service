class QuestionsController < ApplicationController
  def index
    render json: Question.all
  end

  def new
    render plain: 'I display a form for creating new entity'
  end

  def create
    presentation = Presentation.find params[:presentation_id]
    person = Person.find params[:person_id]
    puts params[:anonymous]
    question = Question.new text: params[:text], anonymous: params[:anonymous] || false, created_at: DateTime.now,
                            presentation: presentation, person: person
    question.save!
    render json: question
  end

  def show
    render plain: 'I show one entity'
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
