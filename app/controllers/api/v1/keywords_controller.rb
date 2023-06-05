# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      def index
        keywords = [Keyword.new(1, 'First keyword'), Keyword.new(1, 'Second keyword')]

        render json: KeywordSerializer.new(keywords).serializable_hash.to_json
      end
    end
  end
end
