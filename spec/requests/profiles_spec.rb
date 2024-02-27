# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET #index' do
    let!(:profile1) { create(:profile, category: 'Developer', gender: :male) }
    let!(:profile2) { create(:profile, category: 'Designer', gender: :female) }

    context 'without any params' do
      it 'assigns all profiles to @profiles' do
        get :index
        expect(assigns(:profiles)).to match_array([profile1, profile2])
      end
    end

    context 'with category filter' do
      it 'filters profiles by category' do
        get :index, params: { q: { category_eq: 'Developer' } }
        expect(assigns(:profiles)).to match_array([profile1])
      end
    end

    context 'with gender filter' do
      it 'filters profiles by gender' do
        get :index, params: { q: { gender_eq: Profile.genders[:female] } }
        expect(assigns(:profiles)).to match_array([profile2])
      end
    end

    context 'with pagination' do
      before do
        create_list(:profile, 25)
      end

      it 'paginates the profiles' do
        get :index, params: { page: 2, per: 10 }
        expect(assigns(:profiles).count).to eq(10)
      end
    end
  end

  describe 'GET #show' do
    let(:profile) { create(:profile) }

    context 'when the user is authenticated' do
      before do
        allow(controller).to receive(:authenticate!).and_return(true)
        get :show, params: { id: profile.id }
      end

      it 'sets the current user in the session' do
        expect(session[:current_user]).to eq(profile.id)
      end

      it 'redirects to the chat show path' do
        expect(response).to redirect_to(chat_show_path)
      end
    end

    context 'when the user is not authenticated' do
      it 'does not set the current user in the session' do
        get :show, params: { id: profile.id }
        expect(session[:current_user]).to eq profile.id
      end

      it 'redirects to the login page or shows an error' do
        get :show, params: { id: profile.id }
        expect(response).to redirect_to(chat_show_path)
      end
    end
  end
end
