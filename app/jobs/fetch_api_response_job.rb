# frozen_string_literal: true

class FetchApiResponseJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    Responses::FetchService.new(message_id:).process
  end
end
