class AnswersController < ApplicationController
  before_action only: [:create, :update, :destroy, :create_only_material] do
    is_authorized get_instruction_id, 1
  end

  def index
    answers = nil

    if params[:question_id]
      answers = Answer.all.where question_id: params[:question_id]
    else
      answers = current_person.answers
    end

    render json: answers
  end

  def create
    question = Question.find params[:question_id]
    person = current_person
    answer = Answer.new text: params[:text], anonymous: params[:anonymous] || false, created_at: DateTime.now,
                            question: question, person: person
    answer.save!
    render json: answer
  end

  def show
    render json: Answer.find(params[:id])
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end

  def create_only_material
    question = Question.find params[:question_id]
    person = current_person
    answer = Answer.new text: params[:text] || '', anonymous: params[:anonymous] || false, created_at: DateTime.now,
                            question: question, person: person
    answer.save!

    material = Material.new key: SecureRandom.uuid, person: current_person, attachable: answer
    material.save!

    obj = get_bucket.object material.key + '/${filename}'
    post = obj.presigned_post

    render json: {fields: post.fields, url: post.url, id: material.id, answer: answer}
  end

  def upvote
    vote = Vote.find_or_create_by(person: current_person, votable: Answer.find(params[:id]))
    vote.up = true
    vote.save!

    render json: vote
  end

  def downvote
    vote = Vote.find_or_create_by(person: current_person, votable: Answer.find(params[:id]))
    vote.up = false
    vote.save!

    render json: vote
  end

  def vote
    Vote.find_by(person: current_person, votable: Answer.find(params[:id])).delete

    render status: 200, body: nil
  end

  def accept
    answer = Answer.find params[:id]
    question = answer.question

    if !question.answer
      answer.accepted = true
      answer.save!

      render status: 200, body: nil
    else
      render status: 401, body: nil
    end
  end

  def undo_accept
    answer = Answer.find params[:id]
    question = answer.question

    if question.answer == answer
      answer.accepted = false
      answer.save!

      render status: 200, body: nil
    else
      render status: 401, body: nil
    end
  end

  private

  # @return [Bucket]
  def get_bucket
    # noinspection RubyArgCount
    Aws::S3::Resource.new(region: ENV['AWS_REGION']).bucket(ENV['BUCKET_NAME'])
  end

  def get_instruction_id
    if params[:question_id]
      question = Question.find params[:question_id]

      return 0 if !question
      return question.presentation.instruction.id
    end

    answer = Answer.find params[:id]

    return 0 if !answer
    return answer.question.presentation.instruction.id
  end
end
