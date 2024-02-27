class ApplicationController < ActionController::Base
  protected

  def authenticate!
    return if session[:current_user]

    redirect_to root_path
  end
end
