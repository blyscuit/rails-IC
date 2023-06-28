# frozen_string_literal: true

module Bing
  class SearchService
    BASE_SEARCH_URL = 'https://www.bing.com/search'
    REQUIRED_PARAMS = '&form=QBLH'

    def initialize(keyword_name)
      @keyword_name = keyword_name
    end

    def call
      html = FetchWebpageService.new(url).call

      ParseResultService.new(html.body).call if html
    end

    private

    attr_reader :keyword_name

    def url
      escaped_keyword_name = CGI.escape(keyword_name)
      "#{BASE_SEARCH_URL}?q=#{escaped_keyword_name}#{REQUIRED_PARAMS}"
    end
  end
end
