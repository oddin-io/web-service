class UsersController < ApplicationController
  skip_before_action :valid_session, only: [:create]

  def create
    user = User.new email: params[:email], password: params[:password]
    user.save!
    render json: user
  end

  def show
    render json: current_user
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end
end
