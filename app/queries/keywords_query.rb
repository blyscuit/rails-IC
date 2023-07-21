# frozen_string_literal: true

class KeywordsQuery
  def initialize(scope, filter_params)
    @scope = scope
    @filter = filter_params
  end

  def call
    filter_urls
  end

  private

  attr_reader :filter
  attr_accessor :scope

  def filter_urls
    return scope unless filter

    @scope = filter_ads_top_urls if filter[:adwords_url_contains].present?
    @scope = filter_result_urls if filter[:result_url_contains].present?
    @scope = filter_match_at_least if filter[:word].present? && filter[:match_at_least].present?

    scope
  end

  def filter_ads_top_urls
    scope.where("array_to_string(ads_top_urls, '||') ILIKE ?", "%#{filter[:adwords_url_contains]}%")
  end

  def filter_result_urls
    scope.where("array_to_string(result_urls, '||') ILIKE ?", "%#{filter[:result_url_contains]}%")
  end

  def filter_match_at_least
    scope.where("array_to_string(result_urls, '||') ~* ?", "(#{filter[:word]}.*){#{filter[:match_at_least]},}")
  end
end
