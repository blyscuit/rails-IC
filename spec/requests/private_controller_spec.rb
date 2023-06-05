# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrivateController, type: :request do
  describe 'GET#index' do
    context 'when user is not sign in' do
      it 'redirects to the new user session page' do
        get '/private'

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is sign in' do
      it 'returns success status' do
        sign_in Fabricate(:user)

        get '/private'

        expect(response).to have_http_status(:success)
      end
    end
  end
end
