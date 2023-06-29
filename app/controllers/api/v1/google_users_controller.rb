# frozen_string_literal: true

module Api
  module V1
    class GoogleUsersController < ApplicationController
      skip_before_action :doorkeeper_authorize!, only: %i[create]

      def create
        return render_errors(
          details: I18n.t('authetication.generic_error'),
          status: :bad_request
        ) unless params[:code]
        data = ExternalAuth::FetchGoogleTokenService.new(params[:code]).call
        return render_errors(
          details: I18n.t('authetication.generic_error'),
          status: :unprocessable_entity
        ) unless data

        user = User.new(email: data[:email], password: data[:sub], login_type: :google)
        return render_errors(
          details: user.errors.full_messages,
          status: :unprocessable_entity
        ) unless user.save

        render success: true, status: :created
      end
    end
  end
end
