class TestQuestionsController < ApplicationController
  before_action :set_test_question, only: [:show, :update, :destroy]

  def index
    instruction = Instruction.find params[:instruction_id]
    test = Test.find params[:test_id]
    render json: instruction.test.questions
  end

  def show
    question = Question.find params[:id]
    render json: question
  end

  def create
    test = Test.find params[:test_id]
    attachable = nil
    question = Question.new number: params[:number],
                            description: params[:description],
                            answer: params[:answer],
                            value: params[:value],
                            kind: params[:kind],
                            test: test

    if params[:test_id]
      attachable = Test.find params[:test_id]
    end

    question.attachable = attachable
    question.save!

    render json: question
  end

  def update
    question = Question.find params[:id]
    question.number = params[:number] if params[:number]
    question.description = params[:description] if params[:description]
    question.answer = params[:answer] if params[:answer]
    question.value = params[:value] if params[:value]
    question.kind = params[:kind] if params[:kind]
    question.attachable = params[:attachable] if params[:attachable]
    question.save!
  end

  def destroy
    render json: Question.find(params[:id]).destroy
  end
  
end
