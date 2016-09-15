class CalendarsController < ApplicationController
  def index
    instruction = Instruction.find params[:instruction_id]
    render json: instruction.calendars
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    date = Calendar.new person: current_person, instruction: instruction,
      subject: params[:subject], text: params[:text], date: params[:date]
    date.save!

    render json: date
  end

  def show
    render json: Calendar.find(params[:id])
  end

  def destroy
    Calendar.find(params[:id]).delete
  end
end
