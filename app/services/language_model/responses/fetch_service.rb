# frozen_string_literal: true

module LanguageModel
  module Responses
    class FetchService
      attr_reader :message

      def initialize(message:)
        @message = message
      end

      def process
        hash_result(response)
      end

      private

      def response
        @response ||= LanguageModel::Api::PostService.new(messages:).process
      end

      def messages
        message.profile.messages
      end

      def hash_result(response)
        message = response.dig(:choices, 0, :message)

        {
          content: message[:content],
          sender: 'assistant' # request_body[:name2]
        }
      end
    end
  end
end
