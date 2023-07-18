# frozen_string_literal: true

class KeywordsQuery
  attr_reader :scope, :filter_params

  def initialize(scope, filter_params)
    @scope = scope
    @filter_params = filter_params
  end

  def call
    return filter_ads_top_urls if filter_params[:adwords_url_contains]

    return filter_result_urls if filter_params[:word] && filter_params[:match_at_least]

    scope
  rescue NoMethodError
    scope
  end

  private

  def filter_ads_top_urls
    word = filter_params[:adwords_url_contains]&.downcase

    return scope unless word

    scope.where("array_to_string(ads_top_urls, '||') ILIKE ?", "%#{word}%")
  end

  def filter_result_urls
    word = filter_params[:word]
    number_of_matches = filter_params[:match_at_least]

    return scope if word.blank? || number_of_matches.blank?

    sub_query = Keyword.select('sub_table.id, sub_table.user_id')
                       .from(Keyword.select('id, user_id, unnest(result_urls) as result_url'), 'sub_table')
                       .where('result_url ~* ?', "(#{word}.*){#{number_of_matches},}")

    Keyword.joins("INNER JOIN (#{sub_query.to_sql}) sub_table ON keywords.id = sub_table.id").group(:id)
  end
end
