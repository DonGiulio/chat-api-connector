# frozen_string_literal: true

module Responses
  class FetchService
    include ActionView::RecordIdentifier

    attr_reader :chat

    def initialize(chat_id:)
      @chat = Chat.find chat_id
    end

    def process
      response_message = Message.create!(chat:, **response)

      broadcast_response(response_message)
    end

    private

    def response
      LanguageModel::Responses::FetchService.new(chat:).process
    end

    def broadcast_response(response_message)
      Turbo::StreamsChannel.broadcast_append_to dom_id(chat),
                                                target: 'messages',
                                                partial: 'messages/message',
                                                locals: { message: response_message }
      Turbo::StreamsChannel.broadcast_update_to dom_id(chat),
                                                target: 'typing-indicator',
                                                action: :update,
                                                content: ''
    end
  end
end
