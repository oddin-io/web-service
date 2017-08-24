class TestQuestionsController < ApplicationController
  before_action :set_test_question, only: [:show, :update, :destroy]

  # GET /test_questions
  def index
    @test_questions = TestQuestion.all

    render json: @test_questions
  end

  # GET /test_questions/1
  def show
    render json: @test_question
  end

  # POST /test_questions
  def create
    @test_question = TestQuestion.new(test_question_params)

    if @test_question.save
      render json: @test_question, status: :created, location: @test_question
    else
      render json: @test_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /test_questions/1
  def update
    if @test_question.update(test_question_params)
      render json: @test_question
    else
      render json: @test_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /test_questions/1
  def destroy
    @test_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_question
      @test_question = TestQuestion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def test_question_params
      params.require(:test_question).permit(:number, :question, :answer, :file, :value, :kind, :test_id)
    end
end
