# frozen_string_literal: true

class SearchKeywordJob < ApplicationJob
  def perform(keyword_id)
    keyword = Keyword.includes(:source).where(keywords: { id: keyword_id }).first
    search_engine = keyword.source.name.downcase
    case search_engine
    when 'google'
      search_result = Google::SearchService.new(keyword.name).call
    when 'bing'
      search_result = Bing::SearchService.new(keyword.name).call
    end
    update_keyword(keyword, search_result)
  end

  private

  def update_keyword(keyword, search_result)
    if search_result
      keyword.update search_result.merge(status: :parsed)
    else
      keyword.update({ status: :failed })
    end
  end
end
