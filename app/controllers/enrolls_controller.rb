class EnrollsController < ApplicationController

  def index
    render plain: 'I list all entities'
  end

  def create
    person = Person.find params[:person_id]
    instruction = Instruction.find params[:instruction_id]
    enroll = Enroll.new person: person, instruction: instruction, profile: params[:profile]
    enroll.save!
    render json: enroll
  end

  def show
    render plain: 'I show one entity'
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render json: Enroll.find(params[:id]).destroy
  end
end
