class ChatController < ApplicationController
  before_action :authenticate!

  def show
    return redirect_to root_path unless session[:current_user]

    @messages = Message.where(profile: session[:current_user]).order(created_at: :desc)
  end
end
