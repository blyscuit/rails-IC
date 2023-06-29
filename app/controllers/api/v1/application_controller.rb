# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include Pundit::Authorization
      include ErrorRenderable
      include Rescuable

      before_action :doorkeeper_authorize!

      private

      def current_user
        @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
      end
    end
  end
end
