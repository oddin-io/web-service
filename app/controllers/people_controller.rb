class PeopleController < ApplicationController
  def create
    user = current_user
    person = Person.new name: params[:name], user: user
    person.save!
    render json: person
  end

  def show
    render json: current_user.person
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end
end
