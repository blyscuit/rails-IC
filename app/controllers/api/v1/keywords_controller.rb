# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      before_action :authorize!

      def index
        filtered_keywords
      end

      def create
        if csv_form.save(params[:file], source_param)
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
        keyword = authorized_resources(Keyword).find(params[:id])
        options = { include: [:source] }

        render json: KeywordDetailSerializer.new(keyword, options).serializable_hash.to_json
      end

      private

      def filtered_keywords
        keyword_params = KeywordParams.new(filter_params)
        keywords_query = KeywordsQuery.new(Keyword, keyword_params&.filter)
        pagination, keywords = paginated_authorized(keywords_query.call)
        keyword_presenters = keywords.map { |item| KeywordPresenter.new(item, keyword_params&.filter) }

        render json: KeywordSerializer.new(keyword_presenters, meta: meta_from_pagination(pagination))
      end

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

      def source_param
        params[:source]
      end

      def filter_params
        params[:filter]
      end
    end
  end
end
