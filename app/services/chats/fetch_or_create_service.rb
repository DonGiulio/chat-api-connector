module Chats
  # Chats::FetchOrCreateService
  class FetchOrCreateService
    attr_reader :profile, :assistant

    def initialize(profile:, assistant:)
      @profile = profile
      @assistant = assistant
    end

    def process
      chat = Chat.find_by(profile:, assistant:)
      return chat if chat

      Chats::CreateService.new(profile:, assistant:).process
    end
  end
end
