class PresentationsController < ApplicationController
  def index
    render json: Presentation.all
  end

  def new
    render plain: 'I display a form for creating new entity'
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    person = Person.find params[:person_id]
    presentation = Presentation.new subject: params[:subject], status: 0, created_at: DateTime.now,
                                    instruction: instruction, person: person
    presentation.save!
    render json: presentation
  end

  def show
    render json: Presentation.find(params[:id])
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
