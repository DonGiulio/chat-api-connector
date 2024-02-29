# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chats::CreateService do
  describe '#process' do
    let(:profile) { create(:profile) }

    subject(:process) { described_class.new(profile:).process }

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
      expect(message.sender).to eq(profile.name)
      expect(message.content).to eq(profile.greeting)
    end
  end
end
