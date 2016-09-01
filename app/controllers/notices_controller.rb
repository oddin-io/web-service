class NoticesController < ApplicationController
  def index
    instruction = Instruction.find params[:instruction_id]
    render json: instructions.notices
  end

  def create
    instruction = Instruction.find params[:instruction_id]
    notice = Notice.new person: current_person, instruction: instruction,
      text: params[:text], subject: params[:subject]

    send_emails instruction, current_person, params[:subject], params[:text]
    notice.save!

    render json: notice
  end

  def show
    render json: Notice.find(params[:id])
  end

  def destroy
    Notice.find(params[:id]).delete
  end

  private

  def send_emails(instruction, person, subject, text)
    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
    domain = ENV['MAILGUN_DOMAIN']
    subject = "[#{instruction.event.code}##{instruction.lecture.code}] - #{subject}"
    students = Person.joins(enrolls: [:instruction]).
      where(instructions: {id: instruction.id}).
      where(enrolls: {profile: 0})

    students.each do |student|
      message_params = {
          from: "noreply@#{domain}",
          to: student.email,
          subject: subject,
          text: text
      }
      mg_client.send_message domain, message_params
    end
  end
end
