# frozen_string_literal: true

module Google
  class SearchKeywordJob < ApplicationJob
    queue_as :default

    def perform(keyword)
      search_result = Google::SearchService.new(keyword[:name]).call()
      update_keyword(keyword, search_result)
    end

    private

    def update_keyword(keyword, search_result)
      source = Source.find_or_create_by({ :name => 'Google' })
      keyword.update(
        top_ads_count: search_result[:ads_top_count],
        total_ads_count: search_result[:ads_page_count],
        ads_links: search_result[:ads_top_urls],
        result_count: search_result[:result_count],
        result_links: search_result[:result_urls],
        total_link_count: search_result[:total_link_count],
        html: search_result[:html],
        source: source
      )
    end
  end
end
