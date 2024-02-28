# frozen_string_literal: true

module Chats
  # Chats::CreateService
  class CreateService
    attr_reader :profile, :assistant

    def initialize(profile:, assistant:)
      @profile = profile
      @assistant = assistant
    end

    def process
      chat = Chat.create!(profile:, assistant:)
      Message.create!(chat:, sender: assistant.name, content: assistant.greeting, role: :assistant)
      chat
    end
  end
end
