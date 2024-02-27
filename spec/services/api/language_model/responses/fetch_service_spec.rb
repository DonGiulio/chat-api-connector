require 'rails_helper'

RSpec.describe Api::LanguageModel::Responses::FetchService do
  describe '#process' do
    let(:message) { { "content": 'Test message', "sender": 'User' } }
    let(:fetch_service) { described_class.new(message:) }

    before do
      allow(fetch_service).to receive(:fetch_response).and_return(fetch_response_stub)
    end

    let(:fetch_response_stub) do
      {
        "choices": [
          {
            "message": {
              "role": 'assistant',
              "content": 'Test response'
            }
          }
        ]
      }
    end

    it 'returns a hash with content and sender' do
      result = fetch_service.process
      expect(result).to eq({
                             content: 'Test response',
                             sender: 'Amaya Nkosi'
                           })
    end
  end

  describe '#hash_result' do
    it 'transforms response into hash with content and sender' do
      response = {
        "choices": [
          {
            "message": {
              "content": 'Sample response'
            }
          }
        ]
      }
      fetch_service = described_class.new(message: {})
      expect(fetch_service.send(:hash_result, response)).to eq({
                                                                 content: 'Sample response',
                                                                 sender: 'Amaya Nkosi'
                                                               })
    end
  end
end
