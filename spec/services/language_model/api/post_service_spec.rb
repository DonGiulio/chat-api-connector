require 'rails_helper'

RSpec.describe LanguageModel::Api::PostService do
  describe '#process' do
    subject(:process) { service.process }
    let(:chat) { create(:chat, :with_message) }
    let(:service) { described_class.new(chat:) }
    let(:server) { create(:server) }
    let(:response) { instance_double('HTTParty::Response', body: response_body, ok?: true) }

    before do
      allow(LanguageModel::Api::LoadBalancer::RoundRobinService)
        .to receive(:new)
        .and_return(instance_double(
                      'LanguageModel::Api::LoadBalancer::RoundRobinService', process: server
                    ))
      allow(HTTParty).to receive(:post).with(server.url, anything).and_return(response)
    end

    let(:response_body) do
      {
        "id": 'chatcmpl-1709137651951611392', "object": 'chat.completions', "created": 1_709_137_651, "model": 'everai-v1-gptq',
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
        "usage": { "prompt_tokens": 37, "completion_tokens": 10, "total_tokens": 47 }
      }.to_json
    end

    shared_examples 'returns the response' do
      it 'returns the first choice message as JSON' do
        expect(process).to eq(JSON.parse(response_body, symbolize_names: true))
      end
    end

    context 'when the request is successful' do
      it 'sends a POST request with specific values in the body' do
        service.process

        expect(HTTParty).to have_received(:post) do |url, options|
          expect(url).to eq(server.url)
          body = JSON.parse(options[:body])
          last_message = chat.messages.last
          expect(body['user_input']).to eq last_message.content
          expect(body['name1']).to eq 'User'
          expect(body['name2']).to eq chat.profile.name
          expect(body['greeting']).to eq chat.profile.greeting
          expect(body['context']).to eq chat.profile.context
          expect(body['messages']).to include('role' => last_message.role, 'content' => last_message.content)
        end
      end

      it_behaves_like 'returns the response'
    end

    context 'when the response is too long' do
      let(:response_body) do
        { "id": 'chatcmpl-1709134556616147712', "object": 'chat.completions', "created": 1_709_134_556, "model": 'everai-v1-gptq',
          "choices": [
            {
              "index": 0,
              "finish_reason": 'length',
              "message": { "role": 'assistant', "content": "Sure thing! Here's a continuation of the list:..." }
            }
          ],
          "usage": { "prompt_tokens": 1290, "completion_tokens": 757, "total_tokens": 2047 } }.to_json
      end

      it_behaves_like 'returns the response'
    end

    context 'when the request contains extended chars' do
      before do
        allow(chat.messages.last).to receive(:content).and_return("!@\#$%^&*()_+œw∂∆˚¬")
      end

      it_behaves_like 'returns the response'
    end

    context 'when the response is not 200' do
      before do
        allow(HTTParty).to receive(:post).and_return(instance_double('HTTParty::Response', ok?: false))
      end

      it 'raises an error' do
        expect { process }.to raise_error(LanguageModel::Api::PostService::HttpError, 'http request failed')
      end
    end
  end
end
