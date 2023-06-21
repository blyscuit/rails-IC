# frozen_string_literal: true

module Google
  class ParseResultService
    TOP_ADS_SECTION_ID = 'tvcap'
    BOTTOM_ADS_SECTION_ID = 'bottomads'
    ADS_CLASS = 'uEierd'
    SEARCH_SECTION_ID = 'search'
    SEARCH_RESULT_CLASS = 'yuRUbf'

    def initialize(html)
      @html = html
    end

    def call
      @doc = Nokogiri::HTML(html)

      {
        ads_top_count: ads_top_count,
        ads_page_count: ads_page_count,
        ads_top_urls: ads_top_urls,
        result_count: result_count,
        result_urls: result_urls,
        total_link_count: total_link_count,
        html: html
      }
    end

    private

    attr_reader :html, :doc

    def ads_top_count
      doc.css("div[id='#{TOP_ADS_SECTION_ID}']").css("div[class='#{ADS_CLASS}']").count
    end

    def ads_page_count
      @ads_page_count ||= @doc.css("div[class='#{ADS_CLASS}']").count
    end

    def ads_top_urls
      doc.css("div[id='#{TOP_ADS_SECTION_ID}']").css('a').filter_map { |element| element['href'] }
    end

    def ads_page_urls
      doc.css("div[class='#{ADS_CLASS}']").filter_map { |element| element['href'] }
    end

    def result_count
      @result_count ||= doc.css("div[id='#{SEARCH_SECTION_ID}']").css("div[class='#{SEARCH_RESULT_CLASS}']").count
    end

    def result_urls
      doc.css("div[id='#{SEARCH_SECTION_ID}']").css("div[class='#{SEARCH_RESULT_CLASS}']").css('a').filter_map do |element|
        element['href']
      end
    end

    def total_link_count
      ads_page_count + result_count
    end
  end
end
