class MaterialsController < ApplicationController
  def index
    render json: Material.all
  end

  def new
    render plain: 'I display a form for creating new entity'
  end

  def create
    material = Material.new name: params[:name], mime: params[:mime], file_url: params[:file_url]
    material.save!
    render json: material
  end

  def show
    render json: Material.find(params[:id])
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
