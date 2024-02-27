module ApplicationHelper
  def current_user
    Profile.find session[:current_user]
  end
end
