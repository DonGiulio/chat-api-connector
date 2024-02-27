require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'POST #create' do
    before do
      allow(controller).to receive(:authenticate!)
      allow(controller).to receive(:session).and_return({ current_user: profile.id })
    end

    let!(:profile) { create(:profile) }
    let(:valid_attributes) { { content: 'Hello, World!' } }

    context 'with valid parameters' do
      it 'creates a new Message' do
        expect do
          post :create, params: { message: valid_attributes }
        end.to change(Message, :count).by(1)
      end

      it 'renders a turbo_stream response' do
        post :create, params: { message: valid_attributes }
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
        expect(response).to render_template('messages/_message')
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
