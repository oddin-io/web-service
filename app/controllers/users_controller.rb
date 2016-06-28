class UsersController < ApplicationController
  skip_before_action :valid_session, only: [:create]

  def index
    render json: User.all
  end

  def new
    render plain: 'I display a form for creating new entity'
  end

  def create
    user = User.new email: params[:email], password: params[:password]
    user.save!
    render json: user
  end

  def show
    render json: User.find(params[:id])
  end

  def edit
    render plain: 'I display a form for editing an entity'
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end
end
