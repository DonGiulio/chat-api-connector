# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LanguageModel::Responses::FetchService do
  describe '#process' do
    let(:chat) { create(:chat, assistant: create(:assistant, name: 'Assistant Name')) }
    let(:api_service) { instance_double(LanguageModel::Api::PostService) }
    let(:api_response) do
      {
        'choices' => [
          { 'message' => { 'content' => 'Generated response' } }
        ]
      }.deep_symbolize_keys
    end

    before do
      allow(LanguageModel::Api::PostService).to receive(:new).with(chat:).and_return(api_service)
      allow(api_service).to receive(:process).and_return(api_response)
    end

    subject(:fetch_service) { described_class.new(chat:) }

    it 'calls the PostService and processes the response' do
      result = fetch_service.process
      expect(result[:content]).to eq('Generated response')
      expect(result[:sender]).to eq(chat.assistant.name)
      expect(result[:role]).to eq(:assistant)
    end
  end
end
