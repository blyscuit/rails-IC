# frozen_string_literal: true

module Api
  module V1
    class SearchKeywordsController < ApplicationController
      before_action :authorize!

      def index
        keywords_query = KeywordsQuery.new(Keyword, search_params)
        pagination, keywords = paginated_authorized(keywords_query.call)
        keyword_presenters = keywords.map { |item| KeywordPresenter.new(item, search_params) }

        render json: KeywordSerializer.new(keyword_presenters, meta: meta_from_pagination(pagination))
      end

      private

      def authorize!
        authorize :keyword
      end

      def search_params
        params.require(:filter).permit(:adwords_url_contains)
      end
    end
  end
end
