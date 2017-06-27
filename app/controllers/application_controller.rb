class ApplicationController < ActionController::API
  # Authentication check
  before_action :valid_session

  def is_authorized(instruction_id, minimum_profile)
    instruction_id = instruction_id.to_i

    if instruction_id < 1
      render body: nil, status: 401 and return false
    end

    person = current_person
    enroll = Enroll.where(person_id: person.id, instruction_id: instruction_id).first

    if !enroll
      render body: nil, status: 401 and return false
    end

    if !(enroll.profile >= minimum_profile)
      render body: nil, status: 401 and return false
    end

    return true
  end

  def current_user
    current_person
  end

  # Get the request current person
  #
  # @return [Person]
  def current_person
    session = get_session

    person = session ? session.person : nil
    if person
      Person.update_status
      person.update_activity
    end
    person
  end

  # Check if the session is valid, if isn't output 401 error code
  #
  # @return [boolean]
  def valid_session
    session = get_session

    unless session
      render body: nil, status: 401 and return
    end

    true
  end

  # Get the session of the request
  #
  # @return [Session]
  def get_session
    Session.find_by_token session_token
  end


  # Get request session token
  #
  # @return [String | nil]
  def session_token
    request.headers['Authorization']
  end
end
