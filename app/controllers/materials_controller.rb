class MaterialsController < ApplicationController
  def index
    render json: current_user.person.materials
  end

  def new
    render plain: 'I display a form for creating new entity'
  end

  def create
    material = Material.new file: params[:file]
    material.save!
    render json: material
  end

  def show
    material = Material.find(params[:id])
    render json: material
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
