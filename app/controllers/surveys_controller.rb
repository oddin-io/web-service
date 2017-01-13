class SurveysController < ApplicationController

  def index
    instruction = Instruction.find params[:instruction_id]
    render json: instruction.surveys
  end

end
