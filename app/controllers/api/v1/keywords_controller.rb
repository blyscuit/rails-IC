# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      def index
        keyword = Keyword.new
        keyword.id = 1
        keyword.name = "Hello"
        render json: KeywordSerializer.new(keyword).serializable_hash.to_json
      end
    end
  end
end
