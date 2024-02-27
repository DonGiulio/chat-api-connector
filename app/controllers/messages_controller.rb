# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate!

  def create
    return head :bad_request if message_params[:content].blank?

    message = Message.create!(message_params.merge(profile_id: current_user.id, sender: current_user.name))
    render turbo_stream: turbo_stream.append('messages', partial: 'messages/message', locals: { message: })

    FetchApiResponseJob.perform_later(message.id)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
