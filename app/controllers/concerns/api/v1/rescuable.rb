# frozen_string_literal: true

module Api
  module V1
    module Rescuable
      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordNotFound do
          render_errors(
            details: [I18n.t('api.errors.not_found')],
            status: :not_found
          )
        end

        rescue_from ActionController::ParameterMissing do |exception|
          render_errors(
            details: [exception.param.to_s],
            status: :bad_request
          )
        end

        rescue_from ActiveRecord::RecordInvalid do |exception|
          render_errors(
            details: [exception.to_s],
            status: :bad_request
          )
        end

        rescue_from ActiveRecord::RecordNotSaved do |exception|
          render_errors(
            details: [exception.to_s],
            status: :bad_request
          )
        end
      end
    end
  end
end
