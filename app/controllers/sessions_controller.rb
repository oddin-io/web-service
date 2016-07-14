class SessionsController < ApplicationController
  skip_before_action :valid_session, only: [:create]

  def create
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      session = Session.new
      session.token = SecureRandom.uuid
      session.user = user
      session.save!
      render json: session, status: 201
    else
      render nothing: true, status: 401
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
    render nothing: true, status: 200
  end

  def destroy_all
    Session.destroy_all user_id: current_user.id
    render nothing: true, status: 200
  end
end
