class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :valid_session, except: [:new]

  def current_user
    Session.find_by_token(session_token).user
  end

  def valid_session
    session = Session.find_by_token session_token

    unless session
      render nothing: true, status: 401 and return
    end

    true
  end

  def session_token
    request.headers['X-Session-Token']
  end
end
