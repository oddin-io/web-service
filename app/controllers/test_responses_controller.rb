class TestResponsesController < ApplicationController
  def index
    testResponse = TestResponse.find params[:id]
    render json: testResponse
  end

  def show
    testResponse = TestResponse.find params[:id]
    render json: testResponse
  end

  def create
    test = Test.find params[:test_id]
    testResponse = TestResponse.new  person: current_person,
                                     test: test

    params[:questions].each do |quest|
      question = TestQuestion.find quest[:id]
      #puts "#{quest[:id]}"
      quest[:test_alternatives].each do |alt|
        alternative = TestAlternative.find alt[:id]
        #puts "#{alt[:id]}"
        TestAnswer.create response: quest[:response], choice: alt[:choice], test_response: testResponse, test_question: question, test_alternative: alternative
      end
    end
    testResponse.save!
  end

  def update

  end

  def destroy
    render json: TestResponse.find(params[:id]).destroy
  end
end