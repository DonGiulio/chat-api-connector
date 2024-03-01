require 'rails_helper'

RSpec.describe Messages::NewBroadcast do
  describe '.broadcast' do
    let(:chat) { create(:chat) }
    let(:user_message) { create(:message, chat:, role: 'user') }
    let(:assistant_message) { create(:message, chat:, role: 'assistant') }

    context 'when the message is from the user' do
      it 'broadcasts a new message and shows typing indicator' do
        expect(Turbo::StreamsChannel).to receive(:broadcast_append_to)
          .with(ActionView::RecordIdentifier.dom_id(chat),
                target: 'messages',
                partial: 'messages/message',
                locals: { message: user_message })

        expect(Messages::TypingIndicator::ShowBroadcast).to receive(:broadcast).with(chat:)

        described_class.broadcast(message: user_message)
      end
    end

    context 'when the message is from the assistant' do
      it 'broadcasts a new message and hides typing indicator' do
        expect(Turbo::StreamsChannel).to receive(:broadcast_append_to)
          .with(ActionView::RecordIdentifier.dom_id(chat),
                target: 'messages',
                partial: 'messages/message',
                locals: { message: assistant_message })

        expect(Messages::TypingIndicator::HideBroadcast).to receive(:broadcast).with(chat:)

        described_class.broadcast(message: assistant_message)
      end
    end
  end
end
