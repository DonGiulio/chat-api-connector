# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchApiResponseJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    let(:chat_id) { Faker::Internet.uuid }
    let(:fetch_service_instance) { instance_double(Responses::FetchService) }

    before do
      allow(Responses::FetchService).to receive(:new).with(chat_id:).and_return(fetch_service_instance)
      allow(fetch_service_instance).to receive(:process)
    end

    it 'executes perform' do
      FetchApiResponseJob.perform_now(chat_id:)

      expect(Responses::FetchService).to have_received(:new).with(chat_id:)
      expect(fetch_service_instance).to have_received(:process)
    end

    it 'enqueues the job' do
      expect do
        FetchApiResponseJob.perform_later(chat_id:)
      end.to have_enqueued_job.with(chat_id:)
    end

    it 'matches with enqueued job' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        FetchApiResponseJob.perform_later(chat_id:)
      end.to have_enqueued_job(FetchApiResponseJob).on_queue('default').at(:no_wait)
    end
  end
end
