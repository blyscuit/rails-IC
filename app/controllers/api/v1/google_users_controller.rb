# frozen_string_literal: true

module Api
  module V1
    class GoogleUsersController < ApplicationController

      skip_before_action :doorkeeper_authorize!, only: %i[create]

      def create
        google_auth_service = ExternalAuth::GoogleAuth.new(params[:code])
        data = google_auth_service.get_user
        render_errors(
          details: I18n.t('authetication.generic_error'),
          status: :unprocessable_entity
        ) unless data

        user = User.new(email: data[:email], password: data[:sub], login_type: :google)
        render_errors(
          details: user.errors.full_messages,
          status: :unprocessable_entity
        ) unless user.save

        render success: true, status: :login
      end
    end
  end
end
