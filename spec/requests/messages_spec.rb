# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  include ActionView::RecordIdentifier

  describe 'POST #create' do
    let!(:profile) { create(:profile) }
    let(:chat) { create(:chat) }
    let(:chat_id) { chat.id }
    let(:valid_attributes) do
      { content: 'Hello, World!',
        chat_id: }
    end

    context 'with valid parameters' do
      it 'creates a new Message' do
        expect do
          post :create, params: { message: valid_attributes }
        end.to change(Message, :count).by(1)
      end

      it 'responds with HTTP status :ok' do
        post :create, params: { message: valid_attributes }
        expect(response).to have_http_status(:ok)
      end

      it 'broadcasts a new message using Turbo Streams' do
        expect do
          post :create, params: { message: valid_attributes }
        end.to have_broadcasted_to(dom_id(chat))
      end

      it 'enqueues FetchApiResponseJob' do
        expect do
          post :create, params: { message: valid_attributes }
        end.to have_enqueued_job(FetchApiResponseJob).with(chat_id:)
      end
    end

    context 'with invalid parameters' do
      context 'when content is blank' do
        let(:invalid_attributes) { { content: '' } }

        it 'returns a bad request status and does not create a message' do
          expect do
            post :create, params: { message: invalid_attributes }
          end.not_to change(Message, :count)

          expect(response).to have_http_status(:bad_request)
        end

        it 'does not enqueue FetchApiResponseJob' do
          expect do
            post :create, params: { message: invalid_attributes }
          end.not_to have_enqueued_job(FetchApiResponseJob)
        end
      end
    end
  end
end
