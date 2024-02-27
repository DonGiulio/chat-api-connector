module Responses
  class FetchService
    attr_reader :message

    def initialize(message_id:)
      @message = Message.find message_id
    end

    def process
      response = Api::LanguageModel::Responses::FetchService.new(message:).process

      # Save the response as a new message or update existing logic here
      response_message = Message.create!(profile: message.profile, **response)

      # Broadcast the message using Turbo Streams
      Turbo::StreamsChannel.broadcast_append_to 'messages',
                                                target: 'messages',
                                                partial: 'messages/message',
                                                locals: { message: response_message }
    end
  end
end
