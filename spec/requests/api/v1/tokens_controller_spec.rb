# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TokensController, type: :controller do
  describe 'POST#login' do
    context 'given valid params' do
      it 'returns a refreshable token' do
        post :create, params: token_request_params

        expect(JSON.parse(response.body)['token_type']).to eq('Bearer')
      end
    end

    context 'when missing a client secret' do
      it 'returns an invalid_client error' do
        post :create, params: token_request_params.except!(:client_secret)

        expect(JSON.parse(response.body)['error']).to eq('invalid_client')
      end
    end

    context 'given bad credentials' do
      it 'returns an invalid_grant error' do
        post :create, params: token_request_params.merge(password: 'wrong_pass')

        expect(JSON.parse(response.body)['error']).to eq('invalid_grant')
      end
    end
  end

  context 'when a user refreshes an existing token on time' do
    it 'returns the refreshed token' do
      token = query_token
      post :create, params: token_refresh_params(token['refresh_token'])

      expect(JSON.parse(response.body)['token_type']).to eq('Bearer')
    end
  end

  context 'when a user refreshes a wrogn refresh token' do
    it 'returns an invalid_grant error' do
      post :create, params: token_refresh_params('wrong_token')

      expect(JSON.parse(response.body)['error']).to eq('invalid_grant')
    end
  end
end
