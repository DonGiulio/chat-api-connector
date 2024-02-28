require 'rails_helper'

RSpec.describe LanguageModel::Api::LoadBalancer::RoundRobinService do
  describe '#process' do
    subject(:service) { described_class.new }

    it 'returns the expected API endpoint URL' do
      expected_url = 'http://35.204.143.204:5000/v1/chat/completions'
      expect(service.process).to eq(expected_url)
    end
  end
end
