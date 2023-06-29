# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GoogleUsersController, type: :request do
  describe 'POST#create' do
    context 'given valid credentials' do
      it 'returns http status of created' do
        params = { code: 'ya29.a0AWY7CkkqDANvsQf0T-4gq91WLLxU-ib0ECHiL-4rw11cn8jw7pKIJ4uvg7WKCPKGhRm8LxHKzIRoGN9KhP8GwCHXx6iwCe9KSRHtchwiZ6-aCpdv5Pj0iTTf-ylOkUzTHUGXrQH2oGNm8MMybgzOxvJVTjUraCgYKASASARESFQG1tDrpaOcqGCIfFT9j5gwOnHTsAg0163' }
        ACCESS_TOKEN = 'ya29.a0AWY7CkkqDANvsQf0T-4gq91WLLxU-ib0ECHiL-4rw11cn8jw7pKIJ4uvg7WKCPKGhRm8LxHKzIRoGN9KhP8GwCHXx6iwCe9KSRHtchwiZ6-aCpdv5Pj0iTTf-ylOkUzTHUGXrQH2oGNm8MMybgzOxvJVTjUraCgYKASASARESFQG1tDrpaOcqGCIfFT9j5gwOnHTsAg0163'
        RESULT_BODY = '{
          "iss": "https://accounts.google.com",
          "sub": "110169484474386276334",
          "azp": "1008719970978-hb24n2dstb40o45d4feuo2ukqmcc6381.apps.googleusercontent.com",
          "aud": "1008719970978-hb24n2dstb40o45d4feuo2ukqmcc6381.apps.googleusercontent.com",
          "iat": "1433978353",
          "exp": "1433981953",
          "email": "testuser@gmail.com",
         }'
        #  stub_request(:get, "https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=code").to_return(body: "{ \"access_token\": \"#{ACCESS_TOKEN}\" }")

        # stub_request(:post, %r{googleapis.com/oauth2/v3}).to_return(body: "{ \"access_token\": \"#{ACCESS_TOKEN}\" }")
        # stub_request(:get, %r{googleapis.com/oauth2/v3}).to_return(body: RESULT_BODY)
        post api_v1_google_users_path, params: params

        expect(response).to have_http_status(:created)
      end
    end
  end
end
