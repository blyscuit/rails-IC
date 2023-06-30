# frozen_string_literal: true

class KeywordDetailSerializer < ApplicationSerializer
  attributes :name
  attributes :ads_top_count
  attributes :ads_page_count
  attributes :ads_top_urls
  attributes :result_count
  attributes :result_urls
  attributes :total_link_count
  attributes :html

  has_one :source
end
