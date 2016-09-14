class WorksController < ApplicationController
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
    render plain: 'I update one entity'
  end

  def destroy
    render json: Work.find(params[:id]).delete
  end
end
