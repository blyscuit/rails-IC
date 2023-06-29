# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include ErrorRenderable
      include Rescuable
      include Pagy::Backend
      include Pundit::Authorization

      before_action :doorkeeper_authorize!

      private

      def current_user
        @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
      end

      def paginated_authorized(klass)
        pagy(policy_scope(klass), pagination_params)
      end

      def meta_from_pagination(pagination)
        {
          page: pagination.page,
          per_page: pagination.items,
          total_items: pagination.count
        }
      end

      def pagination_params
        {
          page: params[:page],
          items: params[:per_page]
        }
      end
    end
  end
end
