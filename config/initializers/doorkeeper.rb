# frozen_string_literal: true

Doorkeeper.configure do
  orm :active_record
  base_controller 'ActionController::API'

  api_only

  resource_owner_from_credentials do |_routes|
    User.authenticate(params[:email], params[:password])
  end
  
  # enable password grant
  grant_flows %w[password]

  skip_authorization do
    true
  end

  use_refresh_token
end
