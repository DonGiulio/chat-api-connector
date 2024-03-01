# frozen_string_literal: true

module Responses
  class FetchService
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
      Messages::NewBroadcast.broadcast(message: response_message)
    end
  end
end
