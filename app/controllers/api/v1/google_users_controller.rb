# frozen_string_literal: true

module Api
  module V1
    class GoogleUsersController < ApplicationController

      skip_before_action :doorkeeper_authorize!, only: %i[create]

      def create
        g = ExternalAuth::GoogleAuth.new(params[:code])
        data = g.get_user!
        if data.present?
        user = User.new(email: data['email'], password: data['sub'], login_type: :google)
          if user.save
            render json: 'Success'
          else
            render(json: { error: user.errors.full_messages }, status: 422)
          end
        else
          render(json: { error: 'Invalid request' }, status: 422)
        end
      end
    end
  end
end
