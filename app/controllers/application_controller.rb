class ApplicationController < ActionController::Base
  protected

  def authenticate!
    return if session[:current_user]

    redirect_to root_path
  end

  def current_user
    @current_user ||= Profile.find(session[:current_user])
  end
end
