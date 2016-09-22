class CalendarsController < ApplicationController
  before_action only: [:create, :destroy] do
    is_authorized get_instruction_id, 1
  end

  def index
    instruction = Instruction.find params[:instruction_id]
    render json: instruction.calendars
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    date = Calendar.new person: current_person, instruction: instruction,
      subject: params[:subject], text: params[:text], date: DateTime.parse(params[:date])
    date.save!

    render json: date
  end

  def show
    render json: Calendar.find(params[:id])
  end

  def update
    date = Calendar.find params[:id]
    date.subject = params[:subject] if params[:subject]
    date.text = params[:text] if params[:text]
    date.date = DateTime.parse(params[:date]) if params[:date]

    date.save!
    render json: date
  end

  def destroy
    Calendar.find(params[:id]).delete
  end

  private

  def get_instruction_id
    if params[:instruction_id]
      return params[:instruction_id]
    end

    calendar = Calendar.find params[:id]

    return 0 if !calendar
    return calendar.instruction.id
  end
end
