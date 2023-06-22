# frozen_string_literal: true

require 'csv'

class CsvUploadForm
  include ActiveModel::Validations

  attr_reader :file

  validates_with CsvValidator

  def initialize(current_user)
    @current_user = current_user
  end

  def save(file)
    @file = file
    return false unless file && valid?

    saved_keywords = []
    ActiveRecord::Base.transaction { saved_keywords += keywords.each(&:save) }

    errors.empty?
  end

  private

  def keywords
    CSV.read(file).filter_map do |row_columns|
      keyword = Keyword.new(name: row_columns.to_csv.chomp, user_id: @current_user.id)

      keyword if keyword.valid?
    end
  end
end
