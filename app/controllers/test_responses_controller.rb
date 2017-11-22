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

      if quest[:choice]
        alternative = TestAlternative.find quest[:choice]

        if alternative.correct == true
          value = question.value
        else
          value = 0
        end 
      end

      TestAnswer.create response: quest[:response], value: value, choice: quest[:choice], test_response: testResponse, test_question: question, test_alternative: alternative
    end
    testResponse.save!
  end

  def update

  end

  def destroy
    render json: TestResponse.find(params[:id]).destroy
  end
end