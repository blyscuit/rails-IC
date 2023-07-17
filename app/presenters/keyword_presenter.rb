# frozen_string_literal: true

class KeywordPresenter
  delegate :id, :name, :ads_top_urls, :result_urls, :created_at, :updated_at, to: :keyword

  def initialize(keyword, filter_params)
    @keyword = keyword
    @filter_params = filter_params
  end

  def matching_adword_urls
    return unless defined?(filter_params[:adwords_url_contains]) && filter_params[:adwords_url_contains]

    keyword.ads_top_urls.select { |item| item.downcase.include?(filter_params[:adwords_url_contains].downcase) }
  rescue NoMethodError
    nil
  end

  def matching_result_urls
    return unless filter_params[:word] && filter_params[:match_at_least]

    keyword.result_urls.select { |item|
      item.downcase.match("\\w*(#{filter_params[:word]}.*){#{filter_params[:match_at_least]},}")
    }
  rescue NoMethodError
    nil
  end

  private

  attr_reader :keyword, :filter_params
end
