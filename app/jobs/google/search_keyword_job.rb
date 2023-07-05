# frozen_string_literal: true

module Google
  class SearchKeywordJob < ApplicationJob
    def perform(keyword_id)
      keyword = Keyword.find(keyword_id)
      search_result = Google::SearchService.new(keyword.name).call
      update_keyword(keyword, search_result)
    end

    private

    def update_keyword(keyword, search_result)
      if search_result
        keyword.update search_result.merge(status: :parsed)
      else
        keyword.update({ status: :failed })

        raise Google::Errors::SearchKeywordError
      end
    end
  end
end
