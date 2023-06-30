# frozen_string_literal: true

module Api
  module V1
    module Rescuable
      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error
      end

      def render_not_found_error
        render_errors(
          details: [I18n.t('api.errors.not_found')],
          status: :not_found
        )
      end
    end
  end
end
