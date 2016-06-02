class PeopleController < ApplicationController
  def index
    render json: Person.all
  end

  def new
    render plain: 'I display a form for creating new entity'
  end

  def create
    user = User.find params[:user_id]
    person = Person.new name: params[:name], user: user
    person.save!
    render json: person
  end

  def show
    render json: Person.find(params[:id])
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
