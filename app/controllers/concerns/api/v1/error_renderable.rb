# frozen_string_literal: true

module Api
  module V1
    module ErrorRenderable
      private

      def build_errors(details:, source: nil, meta: nil, code: nil)
        {
          source: { parameter: source }.compact,
          details: details,
          code: code,
          meta: meta
        }.compact_blank!
      end

      def render_errors(details:, source: nil, meta: nil, status: :unprocessable_entity, code: nil)
        errors = build_errors(details: details, source: source, meta: meta, code: code)

        render json: { errors: errors }, status: status
      end

      def render_bad_request
        render_errors(
          details: [I18n.t('api.errors.bad_request')],
          status: :bad_request
        )
      end
    end
  end
end
