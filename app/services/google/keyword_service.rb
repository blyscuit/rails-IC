# frozen_string_literal: true

module Google
  class KeywordService
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '\
                 'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36'

    BASE_SEARCH_URL = 'https://www.google.com/search'

    def initialize(keyword, lang: 'en')
      @escaped_keyword = CGI.escape(keyword)
      @url = "#{BASE_SEARCH_URL}?q=#{@escaped_keyword}&hl=#{lang}&gl=#{lang}"
    end

    def call
      html = WebpageFetchService.new(@url, USER_AGENT).call
      ParserService.new(html.body).call if html
    end
  end
end
