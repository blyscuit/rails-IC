# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      def index
        keywords = Keyword.where(user_id: current_user.id)
        render json: KeywordSerializer.new(keywords).serializable_hash.to_json
      end

      def create
        if csv_form.save(params[:file])
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

      def csv_form
        @csv_form ||= CsvUploadForm.new(current_user)
      end

      def create_success_response
        {
          meta: I18n.t('csv.upload_success')
        }
      end
    end
  end
end
