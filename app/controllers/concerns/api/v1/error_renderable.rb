# frozen_string_literal: true

module Api
  module V1
    module ErrorRenderable
      private

      def render_error(detail, source: nil, status: :unprocessable_entity)
        error = build_error(detail: detail, source: source)
        render_errors [error], status
      end

      def render_errors(jsonapi_errors, status = :unprocessable_entity)
        render json: { errors: jsonapi_errors }, status: status
      end
    end
  end
end
