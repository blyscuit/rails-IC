# frozen_string_literal: true

class KeywordsQuery
  attr_reader :current_user, :filter_params

  def initialize(current_user, filter_params)
    @current_user = current_user
    @filter_params = filter_params
  end

  def call
    return unless filter_params[:adwords_url_contains]

    get_keywords_has_ads_top_urls_contains_word(filter_params[:adwords_url_contains])
  end

  private

  def get_keywords_has_ads_top_urls_contains_word(word)
    current_user.keywords.where("array_to_string(ads_top_urls, '||') ILIKE ?", "%#{word}%")
  end
end
