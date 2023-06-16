# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TokensController, type: :request do
  describe 'POST#login' do
    context 'given valid credentials' do
      it 'returns an access token' do
        post api_v1_tokens_path, params: token_request_params

        expect(JSON.parse(response.body)['token_type']).to eq('Bearer')
      end

      it 'returns success status' do
        post api_v1_tokens_path, params: token_request_params

        expect(response).to have_http_status(:success)
      end
    end

    context 'given credentials with a missing client secret' do
      it 'returns an invalid_client error' do
        post api_v1_tokens_path, params: token_request_params.except!(:client_secret)

        expect(JSON.parse(response.body)['error']).to eq('invalid_client')
      end

      it 'returns unauthorized status' do
        post api_v1_tokens_path, params: token_request_params.except!(:client_secret)

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'given incorrect credentials' do
      it 'returns an invalid_grant error' do
        post api_v1_tokens_path, params: token_request_params.merge(password: 'wrong_pass')

        expect(JSON.parse(response.body)['error']).to eq('invalid_grant')
      end
    end
  end

  context 'when the user refreshes an existing token on time' do
    it 'returns the refreshed token' do
      token = query_token
      post api_v1_tokens_path, params: token_refresh_params(token['refresh_token'])

      expect(JSON.parse(response.body)['token_type']).to eq('Bearer')
    end

    it 'returns success status' do
      token = query_token
      post api_v1_tokens_path, params: token_refresh_params(token['refresh_token'])

      expect(response).to have_http_status(:success)
    end
  end

  context 'when the user refreshes an incorrect refresh token' do
    it 'returns an invalid_grant error' do
      post api_v1_tokens_path, params: token_refresh_params('wrong_token')

      expect(JSON.parse(response.body)['error']).to eq('invalid_grant')
    end

    it 'returns bad_request status' do
      post api_v1_tokens_path, params: token_refresh_params('wrong_token')

      expect(response).to have_http_status(:bad_request)
    end
  end
end
