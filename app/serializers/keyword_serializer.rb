# frozen_string_literal: true

class KeywordSerializer < ApplicationSerializer
  attributes :name,
             :created_at,
             :updated_at,
             :ads_top_urls,
             :result_urls

  attribute :matching_adword_urls, if: proc { |record|
    record&.matching_adword_urls.present?
  }

  attribute :matching_result_urls, if: proc { |record|
    record&.matching_result_urls.present?
  }
end
