# frozen_string_literal: true

class ChatController < ApplicationController
  before_action :authenticate!

  def show
    @messages = Message.where(profile: current_user)
  end
end
