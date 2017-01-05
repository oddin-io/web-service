class EventsController < ApplicationController
  def index
    events = Event.includes(instructions: :people).where(people: {email: current_person.email})
    events = Event.all if current_person.admin

    render json: events
  end

  def create
    event = Event.new name: params[:name], code: params[:code], workload: params[:workload]
    event.save!
    render json: event
  end

  def show
    render json: Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id]).update(name: params[:name], code: params[:code], workload: params[:workload])
    render json: event
  end

  def destroy
    render json: Event.find(params[:id]).destroy
  end
end
