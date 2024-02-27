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
      it 'does not create a new Message' do
        expect do
          post :create, params: { message: { content: '' } }
        end.to change(Message, :count).by(1)
      end
    end
  end
end
