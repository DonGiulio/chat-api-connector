require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  describe 'GET #show' do
    let!(:messages) { create_list(:message, 3) } # Assuming you have a Message factory

    before do
      get :show
    end

    it 'assigns @messages' do
      expect(assigns(:messages)).to eq(messages)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
end
