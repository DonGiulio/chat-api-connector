# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Responses::FetchService do
  describe '#process' do
    subject(:service) { Responses::FetchService.new(message_id:).process }

    let(:message_id) { Faker::Internet.uuid }
    let(:message) { instance_double(Message, profile:) }
    let(:profile) { instance_double(Profile) }
    let(:api_service) { instance_double(LanguageModel::Responses::FetchService, process: api_response) }
    let(:api_response) { { content: 'Response content', sender: 'Response sender' } }
    let(:response_message) { instance_double(Message) }

    before do
      allow(Message).to receive(:find).with(message_id).and_return(message)
      allow(LanguageModel::Responses::FetchService).to receive(:new).with(message:).and_return(api_service)
      allow(Message).to receive(:create!).and_return(response_message)
      allow(Turbo::StreamsChannel).to receive(:broadcast_append_to)
    end

    it 'fetches a response using the API service and creates a new message' do
      service

      expect(Message).to have_received(:create!).with(profile:, content: 'Response content',
                                                      sender: 'Response sender')
    end

    it 'broadcasts the new message using Turbo Streams' do
      service
      expect(Turbo::StreamsChannel).to have_received(:broadcast_append_to).with('messages', target: 'messages',
                                                                                            partial: 'messages/message', locals: { message: response_message })
    end
  end
end
