# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalAuth::FetchGoogleTokenService, type: :service do
  describe '#call' do
    context 'when Google login returns valid responses' do
      it 'returns same email and sub as stub' do
        ACCESS_CODE = 'access_code'
        ACCESS_TOKEN = 'access_token'
        RESULT_BODY = '{ "email": "email", "sub": "sub" }'
        stub_request(:post, %r{googleapis.com/oauth2/v3}).to_return(body: "{ \"access_token\": \"#{ACCESS_TOKEN}\" }")
        stub_request(:get, %r{googleapis.com/oauth2/v3}).to_return(body: RESULT_BODY)
        result = described_class.new(ACCESS_CODE).call
        expect(result[:email]).to eq('email')
        expect(result[:sub]).to eq('sub')
      end
    end

    context 'when Google failed auth code response ' do
      it 'raises error' do
        ACCESS_CODE = 'access_code'
        stub_request(:post, %r{googleapis.com/oauth2/v3}).to_return(status: 422)
        expect do
          described_class.new(ACCESS_CODE).call
        end.to raise_error
      end
    end

    context 'when Google failed access token response ' do
      it 'raises error' do
        ACCESS_CODE = 'access_code'
        ACCESS_TOKEN = 'access_token'
        stub_request(:post, %r{googleapis.com/oauth2/v3}).to_return(body: "{ \"access_token\": \"#{ACCESS_TOKEN}\" }")
        stub_request(:get, %r{googleapis.com/oauth2/v3}).to_return(status: 422)
        expect do
          described_class.new(ACCESS_CODE).call
        end.to raise_error
      end
    end
  end
end
