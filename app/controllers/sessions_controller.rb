class SessionsController < ApplicationController
  def new
    puts 'I display a form for creating new entity'
  end

  def create
    puts 'I create a new entity'
  end

  def show
    puts 'I show the entity'
  end

  def edit
    puts 'I display a form for editing the entity'
  end

  def update
    puts 'I show the entity'
  end

  def destroy
    puts 'I destroy the entity'
  end

end
