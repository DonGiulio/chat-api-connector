class MessagesController < ApplicationController
  before_action :authenticate!

  def create
    message = Message.create!(message_params.merge(profile_id: session[:current_user]))
    render turbo_stream: turbo_stream.append('messages', partial: 'messages/message', locals: { message: })
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
