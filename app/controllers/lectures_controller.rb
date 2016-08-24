class LecturesController < ApplicationController
  def index
    render json: Lecture.includes(instructions: :people).where(people: current_person)
  end

  def create
    lecture = Lecture.new name: params[:name], code: params[:code], workload: [:workload]
    lecture.save!
    render json: lecture
  end

  def show
    render json: Lecture.find(params[:id])
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end
end
