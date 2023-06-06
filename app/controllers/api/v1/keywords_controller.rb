# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      def index
        first_keyword = Keyword.new
        first_keyword.id = 1
        first_keyword.name = 'First keyword'
        second_keyword = Keyword.new
        second_keyword.id = 2
        second_keyword.name = 'Second keyword'

        render json: KeywordSerializer.new([first_keyword, second_keyword]).serializable_hash.to_json
      end
    end
  end
end
