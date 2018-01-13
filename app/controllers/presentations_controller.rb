class PresentationsController < ApplicationController
  before_action only: [:create, :destroy, :update, :close] do
    is_authorized get_instruction_id, 1
  end

  def index
    resp = Presentation.includes(instruction: :people).where(people: current_person)

    resp = Instruction.find(params[:instruction_id]).presentations if params[:instruction_id]

    render json: resp
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    presentation = Presentation.new subject: params[:subject], status: 0, created_at: DateTime.now,
      instruction: instruction, person: current_person
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

  def close
    presentation = Presentation.find params[:id]
    presentation.status = 1
    presentation.save!

    render json: presentation
  end

  private

  def get_instruction_id
    if params[:instruction_id]
      return params[:instruction_id]
    end

    presentation = Presentation.find params[:id]

    return 0 if !presentation
    return presentation.instruction.id
  end
end
