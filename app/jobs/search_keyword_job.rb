# frozen_string_literal: true

class SearchKeywordJob < ApplicationJob
  attr_reader :keyword

  def perform(keyword_id)
    @keyword = Keyword.includes(:source).find(keyword_id)
    search_result = search_service
    update_keyword(search_result)
  end

  private

  def search_service
    source_name = keyword.source.name.downcase
    keyword_name = keyword.name

    return Bing::SearchService.new(keyword_name).call if source_name == 'bing'

    Google::SearchService.new(keyword_name).call
  end

  def update_keyword(search_result)
    if search_result
      keyword.update search_result.merge(status: :parsed)
    else
      keyword.update({ status: :failed })
      raise Errors::SearchKeywordError
    end
  end
end
