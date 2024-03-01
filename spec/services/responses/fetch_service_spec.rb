require 'rails_helper'

RSpec.describe Responses::FetchService do
  describe '#process' do
    subject(:process) { service.process }

    let(:chat) { create(:chat) }
    let(:chat_id) { chat.id }
    let(:service) { described_class.new(chat_id:) }
    let(:generated_content) { 'Generated message content' }
    let(:language_model_service) do
      instance_double(LanguageModel::Responses::FetchService)
    end

    before do
      allow(LanguageModel::Responses::FetchService).to receive(:new)
        .with(chat:)
        .and_return(language_model_service)
      allow(language_model_service).to receive(:process)
        .and_return({ content: generated_content,
                      sender: 'Name',
                      role: :assistant })
      allow(Messages::NewBroadcast).to receive(:broadcast)
    end

    it 'creates a new message with the response content' do
      expect { process }.to change(Message, :count).by(1)
      message = Message.last

      expect(message.content).to eq(generated_content)
      expect(message.chat).to eq(chat)
      expect(message.sender).to eq('Name')
      expect(message.role).to eq('assistant')
    end

    it 'broadcasts the new message using Messages::NewBroadcast' do
      process
      expect(Messages::NewBroadcast).to have_received(:broadcast).with(message: Message.last)
    end
  end
end
