class TestAnswersController < ApplicationController

  def index
    instruction = Instruction.find params[:instruction_id]
    test = Test.find params[:test_id]
    question = Question.find params[:question_id]
    alternative = Alternative.find params [:alternative_id]
    person = current_person
    render json: instruction.test.question.alternative.answers
  end

  def show
      answer = Answer.find params[:id]
      render json: answer
    end

    def create
      question = Question.find params[:question_id]
      alternative = Alternative.find params [:alternative_id]
      person = current_person
      answer = Answer.new answer: params[:answer],
                          question: question
                          alternative: alternative
                          person: person
      answer.save!

      render json: answer
    end

    def destroy
      render json: Answer.find(params[:id]).destroy
    end
end
