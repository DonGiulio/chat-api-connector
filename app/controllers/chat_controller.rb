# frozen_string_literal: true

class ChatController < ApplicationController
  before_action :authenticate!

  def show
    @chat = Chats::FetchOrCreateService
            .new(profile: current_user, assistant:)
            .process
  end

  private

  def assistant
    @assistant ||= Assistant.first
  end
end
