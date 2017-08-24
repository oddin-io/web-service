class TestAlternativesController < ApplicationController
  before_action :set_test_alternative, only: [:show, :update, :destroy]

  # GET /test_alternatives
  def index
    @test_alternatives = TestAlternative.all

    render json: @test_alternatives
  end

  # GET /test_alternatives/1
  def show
    render json: @test_alternative
  end

  # POST /test_alternatives
  def create
    @test_alternative = TestAlternative.new(test_alternative_params)

    if @test_alternative.save
      render json: @test_alternative, status: :created, location: @test_alternative
    else
      render json: @test_alternative.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /test_alternatives/1
  def update
    if @test_alternative.update(test_alternative_params)
      render json: @test_alternative
    else
      render json: @test_alternative.errors, status: :unprocessable_entity
    end
  end

  # DELETE /test_alternatives/1
  def destroy
    @test_alternative.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_alternative
      @test_alternative = TestAlternative.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def test_alternative_params
      params.require(:test_alternative).permit(:answer, :correct, :person_id, :test_id, :test_question_id)
    end
end
