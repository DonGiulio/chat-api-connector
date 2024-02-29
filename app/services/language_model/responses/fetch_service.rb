# frozen_string_literal: true

module LanguageModel
  module Responses
    class FetchService
      attr_reader :chat

      def initialize(chat:)
        @chat = chat
      end

      def process
        hash_result(response)
      end

      private

      def response
        @response ||= LanguageModel::Api::PostService.new(chat:).process
      end

      def hash_result(response)
        message = response.dig(:choices, 0, :message)

        {
          content: message[:content],
          sender: chat.profile.name,
          role: :assistant
        }
      end
    end
  end
end
