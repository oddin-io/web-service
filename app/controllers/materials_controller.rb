class MaterialsController < ApplicationController
  before_action only: [:create] do
    minimum_profile = 1
    minimum_profile = 0 if params[:submission_id]

    is_authorized get_instruction_id, minimum_profile
  end

  def index
    resp = current_person.materials

    resp = Instruction.find(params[:instruction_id]).materials if params[:instruction_id]
    resp = Presentation.find(params[:presentation_id]).materials if params[:presentation_id]
    resp = Answer.find(params[:answer_id]).materials if params[:answer_id]
    resp = Work.find(params[:work_id]).materials if params[:work_id]
    resp = Submission.find(params[:submission_id]).materials if params[:submission_id]

    resp = resp.where checked: true

    render json: resp
  end

  def create
    material = Material.new key: SecureRandom.uuid, person: current_person
    attachable = nil

    if params[:instruction_id]
      attachable = Instruction.find params[:instruction_id]
    elsif params[:presentation_id]
      attachable = Presentation.find params[:presentation_id]
    elsif params[:answer_id]
      attachable = Answer.find param[:answer_id]
    elsif params[:work_id]
      attachable = Work.find params[:work_id]
    elsif params[:submission_id]
      attachable = Submission.find params[:submission_id]
    end

    material.attachable = attachable
    material.save!

    obj = get_bucket.object material.key + '/${filename}'
    post = obj.presigned_post

    resp = {fields: post.fields, url: post.url, id: material.id}
    render json: resp
  end

  def update
    material = Material.find params[:id]

    if !material
      render status: 404, body: nil and return
    end

    object = get_bucket.object(material.key + '/' + params[:name])

    if !object.exists?
      render status: 404, body: nil and return
    end

    material.name = params[:name]
    material.mime = params[:mime]
    material.checked = true
    material.uploaded_at = DateTime.now
    material.save!

    url = object.presigned_url :get
    resp = {material: material, url: url}
    render json: resp
  end

  def show
    material = Material.find params[:id]

    url = get_bucket.object(material.key + '/' + material.name).presigned_url(:get)
    resp = {material: material, url: url}
    render json: resp
  end

  def destroy
    material = Material.find params[:id]
    object = get_bucket.object material.key + '/' + material.name

    object.delete
    material.delete
  end

  private

  # @return [Bucket]
  def get_bucket
    # noinspection RubyArgCount
    Aws::S3::Resource.new(region: ENV['AWS_REGION']).bucket(ENV['BUCKET_NAME'])
  end

  def get_instruction_id
    if params[:instruction_id]
      return params[:instruction_id]
    end

    if params[:presentation_id]
      presentation = Presentation.find params[:presentation_id]

      return 0 if !presentation
      return presentation.instruction.id
    end

    if params[:answer_id]
      answer = Answer.find params[:answer_id]

      return 0 if !answer
      return answer.question.presentation.instruction.id
    end

    if params[:work_id]
      work = Work.find params[:work_id]

      return 0 if !work
      return work.instruction.id
    end

    if params[:submission_id]
      submission = Submission.find params[:submission_id]

      return 0 if !submission
      return submission.work.instruction.id
    end
  end
end
