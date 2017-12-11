class TestResponsesController < ApplicationController
  def index
    test = Test.find params[:test_id]
    render json: test.test_responses
  end

  def show
    testResponse = TestResponse.find params[:id]
    render json: testResponse
  end

  def create
    value = 0
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
      else
        value = 0
      end
      TestAnswer.create response: quest[:response], value: value, choice: quest[:choice], test_response: testResponse, test_question: question, test_alternative: alternative
    end

    testResponse.score = testResponse.test_answers.reduce 0 do |accum, answer| accum += answer.value end

    testResponse.save!
  end

  def update
    testResponse = TestResponse.find params[:id]
    testResponse.closed = true

    params[:test_answers].each do |answer|

      testAnswer = TestAnswer.find answer[:id]

      if answer[:response]
        if answer[:newValue]
          testAnswer.value = answer[:newValue]
        else
          testAnswer.value = 0
        end
      end

      testAnswer.comment = answer[:comment]
      testAnswer.save!
    end

    testResponse.score = testResponse.test_answers.reduce 0 do |accum, answer| accum += answer.value end

    testResponse.save!
  end

  def destroy
    render json: TestResponse.find(params[:id]).destroy
  end
end