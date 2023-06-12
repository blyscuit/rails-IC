# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      skip_before_action :doorkeeper_authorize!

      def create
        registration_form = RegistrationForm.new
        if registration_form.save(create_params)
          render success: true, status: :created
        else
          render json: { error: registration_form.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      private

      def create_params
        params.permit(:email, :password, :password_confirmation, :client_id)
      end
    end
  end
end
