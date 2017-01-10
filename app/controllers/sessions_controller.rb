class SessionsController < ApplicationController
  skip_before_action :valid_session, only: [:create]

  def create
    person = Person.find_by email: params[:email]

    if person && person.authenticate(params[:password])
      session = Session.new
      session.token = SecureRandom.uuid
      session.person = person
      session.save!

      render json: session, status: 201
    else
      render body: nil, status: 401
    end
  end

  def show
    render json: get_session
  end

  def update
    puts 'I show the entity'
  end

  def destroy
    get_session.destroy
    render body: nil, status: 200
  end

  def destroy_all
    Session.destroy_all person: current_person

    render body: nil, status: 200
  end
end
