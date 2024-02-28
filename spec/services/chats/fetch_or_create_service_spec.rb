require 'rails_helper'

RSpec.describe Chats::FetchOrCreateService do
  subject(:process) { described_class.new(profile:, assistant:).process }

  let(:profile) { create(:profile) }
  let(:assistant) { create(:assistant) }

  context 'when the chat already exists' do
    let!(:chat) { create(:chat, profile:, assistant:) }

    it 'returns the existing chat' do
      expect(process).to eq(chat)
    end

    it 'does not create a new chat' do
      expect { process }.not_to change(Chat, :count)
    end
  end

  context 'when the chat does not exist' do
    it 'creates a new chat using Chats::CreateService' do
      allow(Chat).to receive(:find_by).with(profile:, assistant:).and_return(nil)
      expect_any_instance_of(Chats::CreateService).to receive(:process).and_call_original
      process
    end

    it 'returns a new chat' do
      allow(Chat).to receive(:find_by).and_return(nil)
      new_chat = create(:chat)
      allow_any_instance_of(Chats::CreateService).to receive(:process).and_return(new_chat)
      expect(process).to eq(new_chat)
    end
  end
end
