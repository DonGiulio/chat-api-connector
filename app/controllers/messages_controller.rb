# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    return head :bad_request if message_params[:content].blank?

    message = Message.create!(message_params.merge(sender: 'You', role: :user))
    feedback_message(message)
    FetchApiResponseJob.perform_later(chat_id: message_params[:chat_id])

    head :ok
  end

  private

  def feedback_message(message)
    Messages::NewBroadcast.broadcast(message:)
  end

  def chat
    @chat ||= Chat.find(message_params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content, :chat_id)
  end
end
