# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GoogleUsersController, type: :request do
  describe 'POST#create' do
    context 'given valid credentials' do
      it 'returns http status of created' do
        params = { code: 'code' }
        ACCESS_TOKEN = 'access_token'
        RESULT_BODY = '{ "email": "email@email.com", "sub": "123456" }'
        stub_request(:post, %r{googleapis.com/oauth2/v3}).to_return(body: "{ \"access_token\": \"#{ACCESS_TOKEN}\" }")
        stub_request(:get, %r{googleapis.com/oauth2/v3}).to_return(body: RESULT_BODY)
        post api_v1_google_users_path, params: params

        expect(response).to have_http_status(:created)
      end
    end
  end
end
