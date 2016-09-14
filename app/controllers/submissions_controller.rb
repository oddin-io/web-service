class SubmissionsController < ApplicationController
  def index
    render plain: 'I list all entities'
  end

  def create
    render plain: 'I create one entity'
  end

  def show
    render plain: 'I show one entity'
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I delete one entity'
  end
end
