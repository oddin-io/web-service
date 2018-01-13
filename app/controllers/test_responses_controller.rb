class TestResponsesController < ApplicationController
  def index
    test = Test.find params[:test_id]
    render json: test.test_responses
  end

  def show
    test_response = TestResponse.find params[:id]
    render json: test_response
  end

  def create
    value = 0
    test = Test.find params[:test_id]
    test_response = TestResponse.new  person: current_person,
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
      TestAnswer.create response: quest[:response], value: value, choice: quest[:choice], test_response: test_response, test_question: question, test_alternative: alternative
    end

    test_response.score = test_response.test_answers.reduce 0 do |accum, answer| accum += answer.value end

    test_response.save!
  end

  def update
    test_response = TestResponse.find params[:id]
    test_response.closed = true

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

    test_response.score = test_response.test_answers.reduce 0 do |accum, answer| accum += answer.value end

    test_response.save!
  end

  def destroy
    render json: TestResponse.find(params[:id]).destroy
  end
end