# frozen_string_literal: true

class Filter
  include ActiveModel::Model

  NO_FILTER = "no filter"
  NORMAL_FILTER = "normal filter"
  MATCH_AT_LEAST_FILTER = "match at least filter"

  attr_reader :adwords_url_contains, :result_url_contains, :word, :match_at_least

  def initialize(params)
    @adwords_url_contains = params&.dig(:adwords_url_contains)
    @result_url_contains = params&.dig(:result_url_contains)
    @word = params&.dig(:word)
    @match_at_least = params&.dig(:match_at_least)
  end

  def filter_type
    if adwords_url_contains || result_url_contains
      return NORMAL_FILTER
    elsif word || match_at_least
      return MATCH_AT_LEAST_FILTER
    else
      return NO_FILTER
    end
  end
end
