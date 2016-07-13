class InstructionsController < ApplicationController
  def index
    render json: current_user.person.instructions
  end

  def create
    event = Event.find params[:event_id]
    lecture = Lecture.find params[:lecture_id]
    instruction = Instruction.new class_number: params[:class_number],
                                  start_date: params[:start_date], end_date: params[:end_date],
                                  event: event, lecture: lecture
    instruction.save!
    render json: instruction
  end

  def show
    render json: Instruction.find(params[:id])
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end
end
