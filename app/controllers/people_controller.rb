class PeopleController < ApplicationController
  skip_before_action :valid_session, only: [:create, :recover_password, :redefine_password]

  def create
    person = Person.new name: params[:name], email: params[:email], password: params[:password]
    person.save!
    render json: person
  end

  def show
    render json: current_person
  end

  def update
    render plain: 'I update one entity'
  end

  def destroy
    render plain: 'I destroy one entity'
  end

  def redefine_password
    token = RedefineToken.find_by token: params[:token]

    if token && (token.created_at + 1.hour) > Time.now
      person = token.person
      person.password = params[:password]
      person.save!

      render body: nil, status: 200
    else
      render body: nil, status: 401
    end
  end

  def recover_password
    person = Person.find_by email: params[:email]

    if person
      token = SecureRandom.uuid
      url = "#{ENV['REDEFINE_PASSWORD_URL']}?token=#{token}"

      send_email person.email, 'Redefine your password', url

      token = RedefineToken.new token: token, person: person
      token.save!

      render body: nil, status: 200
    else
      render body: nil, status: 401
    end
  end

  private

  def send_email(to, subject, text)
    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
    domain = ENV['MAILGUN_DOMAIN']

    message_params = {
        from: "noreply@#{domain}",
        to: to,
        subject: subject,
        text: text
    }

    mg_client.send_message domain, message_params
  end
end
