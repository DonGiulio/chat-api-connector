# frozen_string_literal: true

class MessagesController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    return head :bad_request if message_params[:content].blank?

    message = Message.create!(message_params.merge(sender: 'You', role: :user))
    feedback_message(message)
    FetchApiResponseJob.perform_later(chat_id: message_params[:chat_id])

    head :ok
  end

  private

  def feedback_message(message)
    Turbo::StreamsChannel.broadcast_append_to dom_id(chat),
                                              target: 'messages',
                                              partial: 'messages/message',
                                              locals: { message: }
  end

  def chat
    @chat ||= Chat.find(message_params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content, :chat_id)
  end
end
