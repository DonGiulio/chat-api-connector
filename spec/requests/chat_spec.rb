# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  describe 'GET #show' do
    let(:profile) { create(:profile) }
    let(:profile_id) { profile.id }
    let(:chat) { create(:chat, profile:) }

    it 'initializes and processes Chats::FetchOrCreateService with correct parameters' do
      expect(Chats::FetchOrCreateService).to receive(:new).with(profile_id:).and_call_original
      expect_any_instance_of(Chats::FetchOrCreateService).to receive(:process).and_return(chat)
      get :show, params: { profile_id: }
    end

    it 'assigns @chat with the result from Chats::FetchOrCreateService' do
      allow_any_instance_of(Chats::FetchOrCreateService).to receive(:process).and_return(chat)
      get :show, params: { profile_id: }
      expect(assigns(:chat)).to eq(chat)
    end

    it 'renders the show template' do
      allow_any_instance_of(Chats::FetchOrCreateService).to receive(:process).and_return(chat)
      get :show, params: { profile_id: }
      expect(response).to render_template('show')
    end

    describe 'when profile_id is not present' do
      it 'raises an error' do
        expect { get :show }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
