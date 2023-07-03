# frozen_string_literal: true

module Api
  module V1
    module Users
      class OmniauthCallbacksController < Devise::OmniauthCallbacksController
        include ErrorRenderable

        rescue_from ArgumentError, with: :render_bad_request
        rescue_from TypeError, with: :render_bad_request
        rescue_from NoMethodError, with: :render_bad_request

        def google_oauth2
          @user = User.from_omniauth(request.env['omniauth.auth'])

          return render_success if @user.persisted?

          render_errors(
            details: @user.errors.full_messages,
            status: :unprocessable_entity
          )
        end

        def failure
          render_errors(
            details: [failure_message],
            status: :unprocessable_entity
          )
        end

        private

        def client_application
          state = JSON.parse(request.env['action_dispatch.request.parameters']['state'])
          app_client_id = state['client_id']

          Doorkeeper::Application.find_by(uid: app_client_id)
        end

        def render_success
          user = @user
          access_token = Doorkeeper::AccessToken.create(
            resource_owner_id: user.id,
            application_id: client_application.id,
            use_refresh_token: true,
            expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
            scopes: ''
          )

          render json: Doorkeeper::OAuth::TokenResponse.new(access_token).body
        end
      end
    end
  end
end
