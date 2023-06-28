# frozen_string_literal: true

module Google
  class SearchService
    BASE_SEARCH_URL = 'https://www.google.com/search'

    def initialize(keyword, lang: :en)
      @keyword = keyword
      @lang = lang
    end

    def call
      html = FetchWebpageService.new(url).call

      ParseResultService.new(html.body).call if html
    end

    private

    attr_reader :keyword, :lang

    def url
      escaped_keyword = CGI.escape(keyword)

      "#{BASE_SEARCH_URL}?q=#{escaped_keyword}&hl=#{lang}&gl=#{lang}"
    end
  end
end
