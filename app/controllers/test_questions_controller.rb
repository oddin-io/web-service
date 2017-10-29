class TestQuestionsController < ApplicationController

  def index
    test = Test.find params[:test_id]
    render json: test.test_questions
  end

  def show
    question = TestQuestion.find params[:id]
    render json: question
  end

  def create
    test = Test.find params[:test_id]
    question = TestQuestion.new number: params[:number],
                                description: params[:description],
                                answer: params[:answer],
                                value: params[:value],
                                kind: params[:kind],
                                comment: params[:comment],
                                test: test
    question.save!

    params[:alternatives].each do |test_alternative|
      TestAlternative.create text: test_alternative[:text], correct: test_alternative[:correct], test_question: question
    end

    render json: question
  end

  def update
    question = TestQuestion.find params[:id]
    question.number = params[:number] if params[:number]
    question.description = params[:description] if params[:description]
    question.answer = params[:answer] if params[:answer]
    question.value = params[:value] if params[:value]
    question.kind = params[:kind] if params[:kind]
    question.comment = params[:comment] if params [:comment]
    question.save!

    params[:alternatives].each do |elem|
      alternative = TestAlternative.find elem[:id]
      alternative.text = elem[:text]
      alternative.correct = elem[:correct]
      alternative.save!
    end

    render json: question
  end

  def destroy
    render json: TestQuestion.find(params[:id]).destroy
  end
  
end