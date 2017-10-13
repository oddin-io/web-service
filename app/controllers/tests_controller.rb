class TestsController < ApplicationController

  def index
    instruction = Instruction.find params[:instruction_id]
    render json: instruction.tests
  end

  def show
    render json: Test.find(params[:id])
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    test = Test.new  title: params[:title],
                     date_available: params[:date_available],
                     available_at: params[:available_at],
                     closes_at: params[:closes_at],
                     instruction: instruction,
                     person: current_person
    test.save!

    render json: test
  end

  def update
    test = Test.find params[:id]
    test.title = params[:title] if params[:title]
    test.date_available = params[:date_available] if params[:date_available]
    test.available_at = params[:available_at] if params[:available_at]
    test.closes_at = params[:closes_at] if params[:closes_at]
    test.save!

    render json: test
  end

  def destroy
    render json: Test.find(params[:id]).destroy
  end

end
