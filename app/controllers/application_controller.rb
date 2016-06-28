class ApplicationController < ActionController::API
  # Authentication check
  before_action :valid_session

  # Get the request current user
  #
  # @return [User]
  def current_user
    session = get_session

    session ? session.user : nil
  end

  # Check if the session is valid, if isn't output 401 error code
  #
  # @return [boolean]
  def valid_session
    session = get_session

    unless session
      render nothing: true, status: 401 and return
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
    request.headers['X-Session-Token']
  end
end
