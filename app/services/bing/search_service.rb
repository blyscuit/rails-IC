# frozen_string_literal: true

module Bing
  class SearchService
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '\
                 'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
    BASE_SEARCH_URL = 'https://www.bing.com/search'
    HEADERS = { 'User-Agent' => USER_AGENT }.freeze

    def initialize(keyword)
      @keyword = keyword
    end

    def call
      html = FetchWebpageService.new(url, HEADERS).call

      ParseResultService.new(html.body).call if html
    end

    private

    attr_reader :keyword

    def url
      escaped_keyword = CGI.escape(keyword)
      # I found out without form=QBLH Bing will not return ads
      "#{BASE_SEARCH_URL}?q=#{escaped_keyword}&form=QBLH"
    end
  end
end
