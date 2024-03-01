require 'rails_helper'

RSpec.describe Messages::TypingIndicator::HideBroadcast do
  describe '.broadcast' do
    let(:chat) { create(:chat) }

    it 'broadcasts to hide the typing indicator' do
      expect(Turbo::StreamsChannel).to receive(:broadcast_update_to).with(
        ActionView::RecordIdentifier.dom_id(chat),
        target: 'typing-indicator',
        action: :update,
        content: ''
      )

      described_class.broadcast(chat:)
    end
  end
end
