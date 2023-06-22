# frozen_string_literal: true

module Google
  class SearchKeywordJob < ApplicationJob
    queue_as :default

    def perform(keyword_id)
      keyword = Keyword.find(keyword_id)
      search_result = Google::SearchService.new(keyword.name).call
      raise Google::Errors::SearchKeywordError unless search_result

      update_keyword(keyword, search_result)
    end

    private

    def update_keyword(keyword, search_result)
      source = Source.find_or_create_by({ name: 'Google' })
      keyword.update(search_result.merge(source: source))
    end
  end
end
