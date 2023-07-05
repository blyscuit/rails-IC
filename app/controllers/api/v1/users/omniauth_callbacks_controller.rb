# frozen_string_literal: true

module Api
  module V1
    module Users
      class OmniauthCallbacksController < Devise::OmniauthCallbacksController
        include ErrorRenderable

        rescue_from ArgumentError, with: :render_bad_request

        def google_oauth2
          @user = User.from_omniauth(auth)

          if @user.persisted?
            render_success
          else
            render_errors(
              details: @user.errors.full_messages,
              status: :unprocessable_entity
            )
          end
        end

        def failure
          render_errors(
            details: [failure_message],
            status: :unprocessable_entity
          )
        end

        private

        def auth
          @auth ||= request.env['omniauth.auth']
        end

        def render_success
          # TODO: Render Doorkeeper Token

          render json: { success: true }
        end

        def render_bad_request
          render_errors(
            details: [I18n.t('api.errors.bad_request')],
            status: :bad_request
          )
        end
      end
    end
  end
end
