# frozen_string_literal: true

class SearchKeywordJob < ApplicationJob
  def perform(keyword_id)
    keyword = Keyword.includes(:source).find(keyword_id)
    keyword_name = keyword.name
    search_result = search_service(keyword).new(keyword_name).call
    update_keyword(keyword, search_result)
  end

  private

  def search_service(keyword)
    source_name = keyword.source.name.downcase
    return Bing::SearchService if source_name == 'bing'

    Google::SearchService
  end

  def update_keyword(keyword, search_result)
    keyword_data = search_result ? search_result.merge(status: :parsed) : { status: :failed }
    keyword.update(keyword_data)
  end
end
