# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate!

  def create
    return head :bad_request if message_params[:content].blank?

    message = Message.create!(message_params.merge(sender: current_user.name, role: :user))
    render turbo_stream: turbo_stream.append('messages', partial: 'messages/message', locals: { message: })

    FetchApiResponseJob.perform_later(chat_id: message_params[:chat_id])
  end

  private

  def message_params
    params.require(:message).permit(:content, :chat_id)
  end
end
