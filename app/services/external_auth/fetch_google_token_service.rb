# frozen_string_literal: true

module ExternalAuth
  class FetchGoogleTokenService
    AUTH_CODE_URL = 'https://www.googleapis.com/oauth2/v3/token'
    ACCESS_TOKEN_URL = 'https://www.googleapis.com/oauth2/v3/userinfo?access_token='
    GRANT_TYPE = 'authorization_code'

    def initialize(access_code)
      @access_code = access_code
    end

    def call
      @access_token ||= fetch_access_token
      return unless access_token

      google = URI("#{ACCESS_TOKEN_URL}#{access_token}")
      response = HTTParty.get(google)
      body = JSON.parse(response.body)

      {
        email: body['email'],
        sub: body['sub']
      }
    end

    private

    attr_reader :access_token

    def app_auth_data
      {
        client_id: Rails.application.credentials.dig(:google_oauth, :client_id),
        client_secret: Rails.application.credentials.dig(:google_oauth, :client_secret),
        redirect_uri: Rails.application.credentials.dig(:google_oauth, :redirect_uri)
      }
    end

    def fetch_access_token
      uri = URI(AUTH_CODE_URL)
      params = {
        code: @access_code,
        client_id: app_auth_data[:client_id],
        client_secret: app_auth_data[:client_secret],
        redirect_uri: app_auth_data[:redirect_uri],
        grant_type: GRANT_TYPE
      }
      response = HTTParty.post(uri, body: params)
      data = JSON.parse(response.body)
      data['access_token']
    end
  end
end
