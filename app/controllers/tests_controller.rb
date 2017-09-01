class TestsController < ApplicationController
  before_action :set_test, only: [:show, :update, :destroy]

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
                     available_at: params[:available_at],
                     instruction: instruction,
                     person: current_person
    test.save!

    #params[:questions].each do |question|
      #Question.create number: question[:number], description: question[:description], answer: question[:answer], value: question[:value], kind: question[:kind], attachable: question[:attachable], test: test
    #end

    render json: test
  end

  def update
    test = Test.find params[:id]
    test.title = params[:title] if params[:title]
    test.available_at = params[:available_at] if params[:available_at]
    test.save!

    #params[:questions].each do |elem|
      #question = Question.find elem[:id]
      #question.number = elem[:number]
      #question.description = elem[:description]
      #question.value = elem[:value]
      #question.kind = elem[:kind]
      #question.attachable = elem[:attachable]
      #question.save!
    #end

    render json: test
  end

  def destroy
    render json: Test.find(params[:id]).destroy
  end

end
