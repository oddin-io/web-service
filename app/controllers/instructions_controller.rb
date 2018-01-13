class InstructionsController < ApplicationController
  def index
    instructions = current_person.instructions
    instructions = Instruction.all if current_person.admin

    render json: instructions
  end

  def create
    event = Event.find params[:event_id]
    lecture = Lecture.find params[:lecture_id]
    instruction = Instruction.new class_code: params[:class_code],
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
    render json: Instruction.find(params[:id]).destroy
  end

  def profile
    instruction = Instruction.find params[:id]
    enroll = instruction.enrolls.find_by person: current_person

    render json: enroll
  end

  def participants
    instruction = Instruction.find params[:id]
    render json: instruction.enrolls
  end
end
