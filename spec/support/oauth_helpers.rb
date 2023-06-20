# frozen_string_literal: true

module OAuthHelpers
  def token_request_params
    @user ||= Fabricate(:user)
    @application ||= Fabricate(:application)

    {
      grant_type: 'password',
      client_id: @application.uid,
      client_secret: @application.secret,
      email: @user.email,
      password: @user.password
    }
  end

  def query_token
    params = token_request_params

    post api_v1_tokens_path, params: params

    JSON.parse(response.body)
  end

  def token_refresh_params(refresh_token)
    @user ||= Fabricate(:user)
    @application ||= Fabricate(:application)

    {
      grant_type: 'refresh_token',
      client_id: @application.uid,
      client_secret: @application.secret,
      email: @user.email,
      password: @user.password,
      refresh_token: refresh_token
    }
  end

  def create_token_header(user = nil)
    user ||= Fabricate(:user)

    application = Fabricate(:application)
    access_token = Fabricate(:access_token, resource_owner_id: user.id, application_id: application.id)

    { 'Authorization' => "Bearer #{access_token.token}" }
  end
end
