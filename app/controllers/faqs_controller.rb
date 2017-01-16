class FaqsController < ApplicationController

  def index
    instruction = Instruction.find params[:instruction_id]
    render json: instruction.faqs
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    faq = Faq.new question: params[:question],
                  answer: params[:answer],
                  instruction: instruction,
                  person: current_person
    faq.save!
    render json: faq
  end

  def destroy
    render json: Faq.find(params[:id]).destroy
  end

  def update
    faq = Faq.find params[:id]
    faq.question = params[:question] if params[:question]
    faq.answer = params[:answer] if params[:answer]
    faq.save!
    render json: faq
  end
end
