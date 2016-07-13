class MaterialsController < ApplicationController
  def index
    render json: current_user.person.materials
  end

  def new
    material = Material.new key: SecureRandom.uuid, person: current_user.person
    material.save!

    obj = get_bucket.object material.key + '/${filename}'
    post = obj.presigned_post

    resp = {fields: post.fields, url: post.url}
    render json: resp
  end

  def create
    material = Material.find_by_key params[:key]
    material.name = params[:name]
    material.mime = params[:mime]
    material.checked = true
    material.uploaded_at = DateTime.now
    material.save!

    url = get_bucket.object(material.key + '/' + material.name).presigned_url(:get)
    resp = {material: material, url: url}
    render json: resp
  end

  def show
    material = Material.find(params[:id])

    url = get_bucket.object(material.key + '/' + material.name).presigned_url(:get)
    resp = {material: material, url: url}
    render json: resp
  end

  def destroy
    material = Material.find(params[:id])
    object = get_bucket.object material.key + '/' + material.name
    object.delete
  end

  private

  # @return [Bucket]
  def get_bucket
    Aws::S3::Resource.new(region: 'us-west-2').bucket('oddin')
  end
end
