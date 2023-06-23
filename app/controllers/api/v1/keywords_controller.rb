# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      before_action :authorize!

      def index
        keywords = policy_scope(Keyword)
        render json: KeywordSerializer.new(keywords).serializable_hash.to_json
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

      def show
        keyword = Keyword.find_by(user: current_user, id: params[:id])

        if keyword
          options = { :include => [:source] }
          render json: KeywordDetailSerializer.new(keyword, options).serializable_hash.to_json
        else
          render_errors(
            details: [I18n.t('keyword.not_found')],
            status: :not_found
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
