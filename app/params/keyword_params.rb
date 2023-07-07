# frozen_string_literal: true

class KeywordParams < ApplicationParams
  attr_reader :filter

  def initialize(params = {})
    super

    @filter = handle_filter_param
  end

  private

  attr_accessor :adwords_url_contains,
                :result_url_contains,
                :word,
                :match_at_least

  def handle_filter_param
    @adwords_url_contains = handle_param(:adwords_url_contains)
    @result_url_contains = handle_param(:result_url_contains)
    @word = handle_param(:word)
    @match_at_least = handle_param(:match_at_least)

    if adwords_url_contains || result_url_contains
      url_filter
    elsif word && match_at_least
      match_at_least_filter
    else
      no_filter
    end
  end

  def url_filter
    { 
      adwords_url_contains: adwords_url_contains,
      result_url_contains: result_url_contains
    }.compact
  end

  def match_at_least_filter
    { 
      word: word,
      match_at_least: match_at_least
    }.compact
  end

  def no_filter
    {}
  end
end
