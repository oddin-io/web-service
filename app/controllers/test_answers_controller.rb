class TestAnswersController < ApplicationController
  before_action :set_test_answer, only: [:show, :update, :destroy]

  # GET /test_answers
  def index
    test_answers = TestAnswer.all

    render json: test_answers
  end

  # GET /test_answers/1
  def show
    render json: test_answer
  end

  # POST /test_answers
  def create
    test_answer = TestAnswer.new(test_answer_params)

    if test_answer.save
      render json: test_answer, status: :created, location: test_answer
    else
      render json: test_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /test_answers/1
  def update
    if test_answer.update(test_answer_params)
      render json: test_answer
    else
      render json: test_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /test_answers/1
  def destroy
    test_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_answer
      test_answer = TestAnswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def test_answer_params
      params.fetch(:test_answer, {})
    end
end
