# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      skip_before_action :doorkeeper_authorize!
      def index
        first_keyword = Keyword.new({ id: 1, name: 'First keyword' })
        second_keyword = Keyword.new({ id: 2, name: 'Second keyword' })

        render json: KeywordSerializer.new([first_keyword, second_keyword]).serializable_hash.to_json
      end
    end
  end
end
