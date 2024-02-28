# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Responses::FetchService do
  describe '#process' do
    subject(:process) { service.process }
    let(:chat) { create(:chat) }
    let(:chat_id) { chat.id }
    let(:service) { described_class.new(chat_id:) }
    let(:generated_content) { 'Generated message content' }
    let(:language_model_service) { instance_double(LanguageModel::Responses::FetchService) }

    before do
      allow(Chat).to receive(:find).with(chat_id).and_return(chat)
      allow(LanguageModel::Responses::FetchService).to receive(:new).with(chat:).and_return(language_model_service)
      allow(language_model_service).to receive(:process).and_return({ content: generated_content, sender: 'Assistant',
                                                                      role: :assistant })
      allow(Turbo::StreamsChannel).to receive(:broadcast_append_to)
    end

    it 'creates a new message with the response content' do
      expect { process }.to change { Message.count }.by(1)
      message = Message.last
      expect(message.content).to eq(generated_content)
      expect(message.chat).to eq(chat)
    end

    it 'broadcasts the new message' do
      process
      expect(Turbo::StreamsChannel).to have_received(:broadcast_append_to).with(
        'messages',
        target: 'messages',
        partial: 'messages/message',
        locals: { message: Message.last }
      )
    end
  end
end
