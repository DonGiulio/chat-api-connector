# frozen_string_literal: true

class ChatController < ApplicationController
  def show
    @chat = Chats::FetchOrCreateService
            .new(profile_id:)
            .process
  end

  private

  def profile_id
    params.require(:profile_id)
  end
end
