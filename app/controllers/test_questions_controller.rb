class TestQuestionsController < ApplicationController

  def index
    test = Test.find params[:test_id]
    render json: test.questions
  end

  def show
    question = Question.find params[:id]
    render json: question
  end

  def create
    test = Test.find params[:test_id]
    question = Question.new number: params[:number],
                            description: params[:description],
                            answer: params[:answer],
                            value: params[:value],
                            kind: params[:kind],
                            comment: params[:comment],
                            test: test
    question.save!

    params[:alternatives].each do |test_alternative|
      Alternative.create text: alternative[:text], correct: alternative[:correct], question: question
    end

    render json: question
  end

  def update
    question = Question.find params[:id]
    question.number = params[:number] if params[:number]
    question.description = params[:description] if params[:description]
    question.answer = params[:answer] if params[:answer]
    question.value = params[:value] if params[:value]
    question.kind = params[:kind] if params[:kind]
    question.comment = params[:comment] if params [:comment]
    question.save!

    params[:alternatives].each do |elem|
      alternative = Alternative.find elem[:id]
      alternative.text = elem[:text]
      alternative.correct = elem[:correct]
      alternative.save!
    end

    render json: question
  end

  def destroy
    render json: Question.find(params[:id]).destroy
  end
  
end