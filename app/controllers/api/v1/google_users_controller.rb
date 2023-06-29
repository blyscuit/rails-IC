# frozen_string_literal: true

module Api
  module V1
    class GoogleUsersController < ApplicationController
      skip_before_action :doorkeeper_authorize!, only: %i[create]

      def create
        data = ExternalAuth::FetchGoogleTokenService.new(create_params).call
        # return render_errors(
        #   details: I18n.t('authetication.generic_error'),
        #   status: :unprocessable_entity
        # ) unless data

        user = User.new(email: data[:email], password: Devise.friendly_token, sub: data[:sub], login_type: :google)
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
