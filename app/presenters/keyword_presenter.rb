# frozen_string_literal: true

class KeywordPresenter
  delegate :id, :name, :ads_top_urls, :result_urls, :created_at, :updated_at, to: :keyword

  def initialize(keyword, filter_params)
    @keyword = keyword
    @filter_params = filter_params
  end

  def matching_adword_urls
    return unless filter_params[:adwords_url_contains]

    adwords_url_contains = filter_params[:adwords_url_contains].downcase
    keyword.ads_top_urls.select do |item|
      item.downcase.include?(adwords_url_contains)
    end
  rescue NoMethodError
    nil
  end

  def matching_result_urls
    return if filter_params[:word].blank? || filter_params[:match_at_least].blank?

    word = filter_params[:word].downcase
    keyword.result_urls.select do |item|
      item.downcase.match("\\w*(#{word}.*){#{filter_params[:match_at_least]},}")
    end
  rescue NoMethodError
    nil
  end

  private

  attr_reader :keyword, :filter_params
end
