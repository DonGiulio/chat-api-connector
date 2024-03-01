require 'rails_helper'

RSpec.describe Messages::TypingIndicator::ShowBroadcast do
  describe '.broadcast' do
    let(:chat) { create(:chat) }

    it 'broadcasts a Turbo Streams update to the correct DOM ID with the typing indicator partial' do
      expect(Turbo::StreamsChannel).to receive(:broadcast_update_to)
        .with(ActionView::RecordIdentifier.dom_id(chat),
              target: 'typing-indicator',
              partial: 'messages/typing_indicator')

      described_class.broadcast(chat:)
    end
  end
end
