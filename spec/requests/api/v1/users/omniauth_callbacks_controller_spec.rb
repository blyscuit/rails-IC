# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::OmniauthCallbacksController, type: :request do
  describe 'POST #google_oauth2' do
    context 'given the email is available' do
      it 'returns a successful response' do
        application = Fabricate(:application)
        allow(Doorkeeper::Application).to receive(:find_by).and_return(application)
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
          {
            provider: :google_oauth2,
            uid: '123545',
            info: { email: 'email@email.com' }
          }
        )

        post '/api/v1/users/auth/google_oauth2/callback'

        expect(response).to have_http_status(:success)
      end
    end

    context 'given the email is not available' do
      it 'returns an unprocessable entity response with errors' do
        existing_email = 'email@email.com'
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
          {
            provider: :google_oauth2,
            uid: '123545',
            info: { email: existing_email }
          }
        )
        Fabricate(:user, email: existing_email)

        post api_v1_user_google_oauth2_omniauth_callback_path

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']['details']).to include('Email has already been taken')
      end
    end

    context 'when OmniAuth returns nil' do
      it 'returns unprocessable_entity error' do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:google_oauth2] = nil

        post api_v1_user_google_oauth2_omniauth_callback_path

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']['details']).to include(I18n.t('api.errors.bad_request'))
      end
    end

    context 'when OmniAuth returns nil email' do
      it 'returns unprocessable_entity error' do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
          {
            provider: :google_oauth2,
            uid: '123545',
            info: { email: nil }
          }
        )
        post api_v1_user_google_oauth2_omniauth_callback_path

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']['details']).to include("Email can't be blank")
      end
    end

    context 'when OmniAuth returns invalid_credentials error' do
      it 'returns unprocessable_entity error' do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

        post api_v1_user_google_oauth2_omniauth_callback_path

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']['details']).to include('Invalid credentials')
      end
    end
  end
end
