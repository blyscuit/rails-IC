# frozen_string_literal: true

module Bing
  class ParseResultService
    TOP_ADS_SECTION_CLASS = 'b_ad b_adTop'
    ADS_CLASS = 'sb_add sb_adTA'
    SIDE_BANNER_ADS_CONTAINER_CLASS = 'sb_add sb_adTA sb_adBrandSidebar ad_sc'
    SIDE_BANNER_ADS_IMAGE_CLASS = 'sb_adImageExtensionFull'
    SEARCH_RESULT_CONTAINER_ID = 'b_results'
    SEARCH_RESULT_CLASS = 'b_algo'
    ADS_LINK_ROLE = 'link'

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
      doc.css("li[class='#{TOP_ADS_SECTION_CLASS}']").css("div[class='#{ADS_CLASS}']").count
    end

    def ads_top_urls
      doc.css("li[class='#{TOP_ADS_SECTION_CLASS}']")
         .css('h2')
         .css("a[role='#{ADS_LINK_ROLE}']")
         .filter_map { |element| element['href'] }
    end

    def ads_page_count
      @ads_page_count = doc.css("div[class*='#{ADS_CLASS}']").count
    end

    def ads_page_urls
      search_result_ad_urls = doc.css("li[class='#{ADS_CLASS}']")
                                 .css('h2')
                                 .css("a[role='#{ADS_LINK_ROLE}']")
                                 .filter_map { |element| element['href'] }

      side_banner_ad_url = doc.css("div[class='#{SIDE_BANNER_ADS_CONTAINER_CLASS}}]")
                              .css("div[class='#{SIDE_BANNER_ADS_IMAGE_CLASS}']")
                              .cass("a[role='#{ADS_LINK_ROLE}']")
                              .filter_map { |element| element['href'] }

      search_result_ad_urls + side_banner_ad_url
    end

    def result_count
      @result_count ||= doc.css("ol[id='#{SEARCH_RESULT_CONTAINER_ID}']")
                           .css("li[class='#{SEARCH_RESULT_CLASS}']").count
    end

    def result_urls
      doc.css("ol[id='#{SEARCH_RESULT_CONTAINER_ID}']")
         .css("li[class='#{SEARCH_RESULT_CLASS}']")
         .css('h2>a')
         .filter_map { |element| element['href'] }
    end

    def total_link_count
      ads_page_count + result_count
    end
  end
end
