class InformativesController < ApplicationController
  def index
    instruction = Instruction.find params[:instruction_id]
    render json: instructions.informatives
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    informative = Informative.new person: current_person, instruction: instruction,
      text: params[:text]
    informative.save!

    render json: informative
  end

  def show
    render json: Informative.find(params[:id])
  end

  def destroy
    Informative.find(params[:id]).delete
  end
end
