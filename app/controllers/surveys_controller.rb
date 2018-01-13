class SurveysController < ApplicationController

  def index
    instruction = Instruction.find params[:instruction_id]
    render json: instruction.surveys
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    survey = Survey.new title: params[:title],
      question: params[:question],
      instruction: instruction,
      person: current_person
    survey.save!

    params[:alternatives].each do |alternative|
      Alternative.create description: alternative[:description], survey: survey
    end

    render json: survey
  end

  def destroy
    render json: Survey.find(params[:id]).destroy
  end

  def update
    survey = Survey.find params[:id]
    survey.title = params[:title] if params[:title]
    survey.question = params[:question] if params[:question]
    survey.save!

    params[:alternatives].each do |elem|
      alternative = Alternative.find elem[:id]
      alternative.description = elem[:description]
      alternative.save!
    end

    render json: survey
  end

  def close
    survey = Survey.find params[:id]
    survey.closed = true if survey.closed == nil
    survey.save!
    render json: survey
  end

  def choose
    alternative = Alternative.find params[:id]
    survey = alternative.survey
    choice = Choice.new alternative: alternative, survey: survey, person: current_person
    choice.save!

    render json: survey
  end

end
