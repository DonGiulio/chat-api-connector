# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  describe 'GET #show' do
    let(:profile) { create(:profile) }
    let(:assistant) { create(:assistant) }
    let(:chat) { create(:chat, profile:, assistant:) }

    before do
      allow(controller).to receive(:authenticate!).and_return(true)
      allow(controller).to receive(:current_user).and_return(profile)
    end

    it 'initializes and processes Chats::FetchOrCreateService with correct parameters' do
      expect(Chats::FetchOrCreateService).to receive(:new).with(profile:, assistant:).and_call_original
      expect_any_instance_of(Chats::FetchOrCreateService).to receive(:process).and_return(chat)
      get :show
    end

    it 'assigns @chat with the result from Chats::FetchOrCreateService' do
      allow_any_instance_of(Chats::FetchOrCreateService).to receive(:process).and_return(chat)
      get :show
      expect(assigns(:chat)).to eq(chat)
    end
  end
end
