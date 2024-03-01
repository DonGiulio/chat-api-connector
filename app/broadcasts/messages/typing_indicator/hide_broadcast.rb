module Messages
  module TypingIndicator
    # usage: Messages::TypingIndicator::HideBroadcast.broadcast(chat: chat)
    class HideBroadcast < BaseBroadcast
      class << self
        def broadcast(chat:)
          Turbo::StreamsChannel.broadcast_update_to dom_id(chat),
                                                    target: 'typing-indicator',
                                                    action: :update,
                                                    content: ''
        end
      end
    end
  end
end
