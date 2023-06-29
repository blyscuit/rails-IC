# frozen_string_literal: true

module Api
  module V1
    class GoogleUsersController < ApplicationController
      skip_before_action :doorkeeper_authorize!, only: %i[create]

      def create
        auth = Doorkeeper::GrantsAssertion::Devise::OmniAuth.auth_hash(
          provider: :google_oauth2,
          assertion: create_params['code']
        )
        Rails.logger.debug 'auth...'
        Rails.logger.debug auth
        auth = ExternalAuth::FetchGoogleTokenService.new(create_params).call
        # return render_errors(
        #   details: I18n.t('authetication.generic_error'),
        #   status: :unprocessable_entity
        # ) unless data
        Rails.logger.debug auth

        user = User.new(email: auth[:email], password: Devise.friendly_token, sub: auth[:sub], login_type: :google)
        user.save!

        render success: true, status: :created
      end

      private

      def create_params
        params.require(:code)
      end
    end
  end
end
