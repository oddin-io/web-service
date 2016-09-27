class WorksController < ApplicationController
  before_action only: [:create, :update, :destroy] do
    is_authorized get_instruction_id, 1
  end

  def index
    render json: Work.all.where(instruction_id: params[:instruction_id])
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    person = current_person

    work = Work.new subject: params[:subject], description: params[:description],
      deadline: params[:deadline] || Date.tomorrow() - 1.minute, person: person, instruction: instruction
    work.save!

    render json: work
  end

  def show
    render json: Work.find(params[:id])
  end

  def update
    work = Work.find params[:id]
    work.subject = params[:subject] if params[:subject]
    work.description = params[:description] if params[:description]
    work.deadline = DateTime.parse(params[:deadline]) if params[:deadline]

    work.save!
    render json: work
  end

  def destroy
    render json: Work.find(params[:id]).delete
  end

  def get_instruction_id
    if params[:instruction_id]
      return params[:instruction_id]
    end

    work = Work.find params[:id]

    return 0 if !work
    return work.instruction.id
  end
end
