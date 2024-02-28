require 'rails_helper'

RSpec.describe Chats::CreateService do
  describe '#process' do
    let(:profile) { create(:profile) }
    let(:assistant) { create(:assistant, name: 'Assistant', greeting: 'Hello') }

    subject(:process) { described_class.new(profile:, assistant:).process }

    it 'creates a new chat' do
      expect { process }.to change(Chat, :count).by(1)
    end

    it 'creates a new message in the chat' do
      expect { process }.to change(Message, :count).by(1)
    end

    it 'associates the new message with the correct chat and sender' do
      process
      message = Message.last

      expect(message.chat.profile).to eq(profile)
      expect(message.chat.assistant).to eq(assistant)
      expect(message.sender).to eq(assistant.name)
      expect(message.content).to eq(assistant.greeting)
    end
  end
end
