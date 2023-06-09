# frozen_string_literal: true

module Csv
  class CsvImportService
    require 'csv'

    def initialize(user)
      @user = user
    end

    def call(file)
      return if file.nil?

      opened_file = File.open(file)

      CSV.foreach(opened_file) do |row|
        keyword_hash = { 'name' => row }
        keyword = Keyword.find_or_create_by!(keyword_hash)

        keyword_user_hash = { 'keyword' => keyword, 'user' => @user }
        KeywordUser.find_or_create_by!(keyword_user_hash)
        # TODO: Create separate job to import each keyword
      end
    end
  end
end
