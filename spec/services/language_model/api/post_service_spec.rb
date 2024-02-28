require 'rails_helper'

RSpec.describe LanguageModel::Api::PostService do
  describe '#process' do
    subject(:process) { service.process }
    let(:chat) { create(:chat, :with_message) }
    let(:service) { described_class.new(chat:) }
    let(:uri) { 'http://example.com/api_endpoint' }

    let(:response_body) do
      {
        "id": 'chatcmpl-1709137651951611392',
        "object": 'chat.completions',
        "created": 1_709_137_651,
        "model": 'everai-v1-gptq',
        "choices": [
          {
            "index": 0,
            "finish_reason": 'stop',
            "message": {
              "role": 'assistant',
              "content": "Yeah, sure. What's up?"
            }
          }
        ],
        "usage": {
          "prompt_tokens": 37,
          "completion_tokens": 10,
          "total_tokens": 47
        }
      }.to_json
    end

    let(:response) { instance_double('HTTParty::Response', body: response_body) }

    before do
      allow(LanguageModel::Api::LoadBalancer::RoundRobinService)
        .to receive(:new)
        .and_return(instance_double(
                      'LanguageModel::Api::LoadBalancer::RoundRobinService', process: uri
                    ))
      allow(HTTParty).to receive(:post).with(uri, anything).and_return(response)
    end

    it 'sends a POST request with specific values in the body' do
      service.process

      expect(HTTParty).to have_received(:post) do |url, options|
        expect(url).to eq(uri)
        body = JSON.parse(options[:body])
        last_message = chat.messages.last
        expect(body['user_input']).to eq last_message.content
        expect(body['name1']).to eq chat.profile.name
        expect(body['name2']).to eq chat.assistant.name
        expect(body['greeting']).to eq chat.assistant.greeting
        expect(body['context']).to eq chat.assistant.description
        expect(body['messages']).to include('role' => last_message.role, 'content' => last_message.content)
      end
    end

    it 'parses the response as JSON and symbolizes keys' do
      expect(process).to eq(JSON.parse(response_body, symbolize_names: true))
    end
  end
end
