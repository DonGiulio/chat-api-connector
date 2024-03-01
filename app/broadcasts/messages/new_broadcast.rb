module Messages
  # usage: Messages::NewBroadcast.broadcast(message: message)
  class NewBroadcast < BaseBroadcast
    class << self
      def broadcast(message:)
        Turbo::StreamsChannel.broadcast_append_to dom_id(message.chat),
                                                  target: 'messages',
                                                  partial: 'messages/message',
                                                  locals: { message: }

        message.role == 'user' ? show_typing_indicator(message) : hide_typing_indicator(message)
      end

      private

      def show_typing_indicator(message)
        Messages::TypingIndicator::ShowBroadcast.broadcast(chat: message.chat)
      end

      def hide_typing_indicator(message)
        Messages::TypingIndicator::HideBroadcast.broadcast(chat: message.chat)
      end
    end
  end
end
