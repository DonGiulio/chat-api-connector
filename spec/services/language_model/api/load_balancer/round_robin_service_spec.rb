require 'rails_helper'

RSpec.describe LanguageModel::Api::LoadBalancer::RoundRobinService do
  describe '#process' do
    let!(:server_1) { create(:server, name: 'server 1', created_at: 30.minutes.ago) }
    let!(:server_2) { create(:server, name: 'server 2', created_at: 20.minutes.ago) }
    let!(:server_3) { create(:server, name: 'server 3', created_at: 10.minutes.ago) }
    let(:test_redis_key) { 'test_round_robin_index' }

    before do
      allow(ENV).to receive(:fetch).with('REDIS_ROUND_ROBIN_INDEX', anything).and_return(test_redis_key)
      Rails.cache.write(test_redis_key, nil)
    end

    after do
      Rails.cache.delete(test_redis_key)
    end

    it 'returns the first server for the first call' do
      expect(subject.process).to eq(server_1)
    end

    it 'cycles through servers on subsequent calls' do
      first_call_server = subject.process
      second_call_server = subject.process
      third_call_server = subject.process
      fourth_call_server = subject.process

      expect(first_call_server).to eq(server_1)
      expect(second_call_server).to eq(server_2)
      expect(third_call_server).to eq(server_3)
      expect(fourth_call_server).to eq(server_1)
    end

    it 'updates the index in the cache' do
      subject.process
      expect(Rails.cache.read(test_redis_key)).to eq(0)
    end

    context 'when there are no servers' do
      before { Server.delete_all }

      it 'returns nil' do
        expect(subject.process).to be_nil
      end
    end
  end

  describe 'load balancing efficiency' do
    let!(:server1) { create(:server, name: 'server-1', url: 'http://example.com/api1') }
    let!(:server2) { create(:server, name: 'server-2', url: 'http://example.com/api2') }
    let(:request_count) { 1000 }
    let(:server_distribution) { Hash.new(0) }

    before do
      request_count.times do
        server = described_class.new.process
        server_distribution[server.name] += 1
      end
    end

    it 'allocates requests evenly between the two servers' do
      distribution_percentage = server_distribution.values.map { |count| (count.to_f / request_count) * 100 }
      distribution_percentage.each do |percentage|
        expect(percentage).to be_within(1).of(50)
      end
    end
  end
end
