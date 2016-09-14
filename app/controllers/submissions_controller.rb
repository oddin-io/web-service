class SubmissionsController < ApplicationController
  def index
    render json: Submission.all.where(work_id: params[:work_id])
  end

  def create
    work = Work.find params[:work_id]
    person = current_person

    submission = Submission.new text: params[:text] || '', person: person, work: work
    submission.save!

    render json: submission
  end

  def show
    render json: Submission.find(params[:id])
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render json: Submission.find(params[:id]).delete
  end
end
