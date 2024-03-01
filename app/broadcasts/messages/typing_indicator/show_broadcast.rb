module Messages
  module TypingIndicator
    # usage: Messages::TypingIndicator::ShowBroadcast.broadcast(chat: chat)
    class ShowBroadcast < BaseBroadcast
      class << self
        def broadcast(chat:)
          Turbo::StreamsChannel.broadcast_update_to dom_id(chat),
                                                    target: 'typing-indicator',
                                                    partial: 'messages/typing_indicator'
        end
      end
    end
  end
end
