# frozen_string_literal: true

module Chats
  # Chats::FetchOrCreateService
  class FetchOrCreateService
    attr_reader :profile

    def initialize(profile_id:)
      @profile = Profile.find profile_id
    end

    def process
      chat = Chat.find_by(profile:)
      return chat if chat

      Chats::CreateService.new(profile:).process
    end
  end
end
