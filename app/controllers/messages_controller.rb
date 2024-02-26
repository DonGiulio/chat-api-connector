class MessagesController < ApplicationController
  def create
    message = Message.create!(message_params.merge(profile: Profile.first))
    render turbo_stream: turbo_stream.append('messages', partial: 'messages/message', locals: { message: })
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
