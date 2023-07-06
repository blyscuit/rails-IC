# frozen_string_literal: true

module Api
  module V1
    module Users
      class OmniauthCallbacksController < Devise::OmniauthCallbacksController
        include ErrorRenderable

        rescue_from ArgumentError, with: :render_bad_request

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

        def render_success
          # TODO: Render Doorkeeper Token

          render json: { success: true }
        end
      end
    end
  end
end
