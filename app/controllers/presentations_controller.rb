class PresentationsController < ApplicationController
  def index
    render json: Presentation.includes(instruction: :people).where(people: {user_id: current_user.id})
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
