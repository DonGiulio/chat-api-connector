# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  describe 'GET #show' do
    let!(:user) { create(:profile) }
    let!(:other_user) { create(:profile) }
    let!(:user_messages) { create_list(:message, 3, profile: user) }
    let!(:other_user_messages) { create_list(:message, 2, profile: other_user) }

    context 'when the user is logged in' do
      before do
        session[:current_user] = user.id
        get :show
      end

      it 'assigns the correct messages to @messages' do
        expect(assigns(:messages)).to match_array(user_messages.sort_by(&:created_at).reverse)
      end

      it 'does not include other users\' messages' do
        assigns(:messages).each do |message|
          expect(message.profile_id).to eq(user.id)
        end
      end
    end

    context 'when the user is not logged in' do
      before do
        get :show
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end

      it 'does not assign @messages' do
        expect(assigns(:messages)).to be_nil
      end
    end
  end
end
