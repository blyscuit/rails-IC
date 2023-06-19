# frozen_string_literal: true

module Api
  module V1
    class ConfirmationsController < Devise::ConfirmationsController
      def after_confirmation_path_for(_resource_name, _resource)
        success_messages_path
      end
    end
  end
end
