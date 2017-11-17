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
      TestAnswer.create answer: quest[:answer], choice: quest[:choice]
    end

    testResponse.save!
  end

  def update

  end

  def destroy
    render json: TestResponse.find(params[:id]).destroy
  end
end
