# frozen_string_literal: true

module Api
  module V1
    class PrivateController < ApplicationController
      def sample
        render json: KeywordSerializer.new(Keyword.new(1, 'Hello')).serializable_hash.to_json
      end
    end
  end
end
