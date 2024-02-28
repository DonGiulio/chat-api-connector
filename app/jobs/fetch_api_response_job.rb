# frozen_string_literal: true

class FetchApiResponseJob < ApplicationJob
  queue_as :default

  def perform(chat_id:)
    Responses::FetchService.new(chat_id:).process
  end
end
