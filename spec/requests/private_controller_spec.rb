# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrivateController, type: :controller do
  describe 'GET#index' do
    context 'when user is not sign in' do
      it 'returns redirect status' do
        get :index

        expect(response).to have_http_status(:found)
      end
    end

    context 'when user is sign in' do
      before(:each) do
        sign_in Fabricate(:user)
      end

      it 'returns expected status' do
        get :index

        expect(response).to have_http_status(:success)
      end
    end
  end
end
