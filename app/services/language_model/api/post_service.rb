# frozen_string_literal: true

module LanguageModel
  module Api
    # LanguageModel::Api::PostService
    class PostService
      attr_reader :chat

      POST_BODY_TEMPLATE_FILE = 'app/services/language_model/api/templates/post.json.erb'

      def initialize(chat:)
        @chat = chat
      end

      def process
        response = HTTParty.post(uri,
                                 body: request_body,
                                 headers: { 'Content-Type' => 'application/json' })
        JSON.parse(response.body).deep_symbolize_keys
      end

      private

      def uri
        LanguageModel::Api::LoadBalancer::RoundRobinService.new.process
      end

      def request_body
        ERB.new(template).result(binding)
      end

      def template
        File.read(Rails.root.join(POST_BODY_TEMPLATE_FILE))
      end
    end
  end
end
