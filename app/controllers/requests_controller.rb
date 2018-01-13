class RequestsController < ApplicationController

  def index
    presentation = Presentation.find params[:presentation_id]
    render json: presentation.requests
  end

  def create
    presentation = Presentation.find params[:presentation_id]
    request = Request.new presentation: presentation,
      person: current_person
    request.save!

    render json: request
  end

  def update
    request = Request.find params[:id]
    request.status = true

    request.save!

    render json: request
  end
end
