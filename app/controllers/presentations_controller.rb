class PresentationsController < ApplicationController
  def index
    resp = Presentation.includes(instruction: :people).where(people: {user_id: current_user.id})

    resp = Instruction.find(params[:instruction_id]).presentations if params[:instruction_id]

    render json: resp
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    person = Person.find current_user.person.id
    presentation = Presentation.new subject: params[:subject], status: 0, created_at: DateTime.now,
                                    instruction: instruction, person: person
    presentation.save!
    render json: presentation
  end

  def show
    render json: Presentation.find(params[:id])
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end
end
