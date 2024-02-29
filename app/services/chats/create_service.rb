# frozen_string_literal: true

module Chats
  # Chats::CreateService
  class CreateService
    attr_reader :profile

    def initialize(profile:)
      @profile = profile
    end

    def process
      chat = Chat.create!(profile:)
      Message.create!(chat:, sender: profile.name, content:, role: :assistant)
      chat
    end

    private

    def content
      profile.greeting
    end
  end
end
