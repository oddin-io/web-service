class LecturesController < ApplicationController
  def index
    render plain: 'I list all entities'
  end

  def new
    render plain: 'I display a form for creating new entity'
  end

  def create
    render plain: 'I create new entity'
  end

  def show
    render plain: 'I show one entity'
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
