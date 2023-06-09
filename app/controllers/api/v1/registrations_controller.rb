# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      skip_before_action :doorkeeper_authorize!

      def create
        @registerable = DoorkeeperRegisterableForm.new
        client_app = Doorkeeper::Application.find_by(uid: user_params[:client_id])
        unless client_app
          render json: { error: I18n.("doorkeeper.errors.messages.invalid_client") }, status: :unauthorized
        end
        allowed_params = user_params.except(:client_id)
        user = User.new(allowed_params)

        if user.save
          render json: @registerable.render_user(user, client_app), status: :ok
        else
          render json: { error: user.errors }, status: :unprocessable_entity
        end
      end

      def user_params
        params.permit(:email, :password, :client_id)
      end
    end
  end
end
