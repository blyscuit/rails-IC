# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      include Pagy::Backend
      before_action :authorize!

      def index
        render json: KeywordSerializer.new(keywords, meta: meta_from_pagy(pagy))
        pagy, keywords = pagy(policy_scope(Keyword), pagination_params)
      end

      def create
        if csv_form.save(params[:file], source_name(params))
          render json: create_success_response
        else
          render_errors(
            details: csv_form.errors.full_messages,
            code: :invalid_file,
            status: :unprocessable_entity
          )
        end
      end

      private

      def authorize!
        authorize :keyword
      end

      def csv_form
        @csv_form ||= CsvUploadForm.new(current_user)
      end

      def create_success_response
        {
          meta: I18n.t('csv.upload_success')
        }
      end

      def source_name(_params)
        # TODO: Read source_name from parameter

        'Google'
      end
    end
  end
end
