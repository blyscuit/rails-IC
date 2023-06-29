# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include Pundit::Authorization
      include ErrorRenderable
      include Rescuable

      before_action :doorkeeper_authorize!

      def raw_resources(klass, policy_scope_klass = nil)
        resolve_policy_scope(klass, policy_scope_klass)
      end

      def resolve_policy_scope(scope, policy_scope_klass)
        return policy_scope(scope) unless policy_scope_klass

        policy_scope_klass.new(current_user, scope).resolve
      end

      private

      def current_user
        @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
      end
    end
  end
end
