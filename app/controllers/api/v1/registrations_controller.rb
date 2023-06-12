# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      skip_before_action :doorkeeper_authorize!

      def create
        validation = RegistrationForm.new(sign_up_params)
        if validation.save
          render success: true, status: :created
        else
          render json: { error: validation.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      private

      def sign_up_params
        params.permit(:email, :password, :password_confirmation, :client_id)
      end
    end
  end
end
