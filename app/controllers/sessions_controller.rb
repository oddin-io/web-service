class SessionsController < ApplicationController
  def new
    puts 'I display a form for creating new entity'
  end

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
    session = Session.find_by_token params[:token]
    render json: session
  end

  def edit
    puts 'I display a form for editing the entity'
  end

  def update
    puts 'I show the entity'
  end

  def destroy
    Session.find_by_token(params[:token]).destroy
    render nothing: true, status: 200
  end

  def destroy_all
    Session.destroy_all(user_id: params[:user_id])
    render nothing: true, status: 200
  end
end
