# frozen_string_literal: true

require 'csv'

class CsvUploadForm
  include ActiveModel::Validations

  attr_reader :file

  validates_with CsvValidator

  def initialize(current_user)
    @current_user = current_user
  end

  def save(file, source_name)
    @file = file
    return false unless file && valid?

    ActiveRecord::Base.transaction {
      source = Source.find_or_create_by({ name: source_name })
      keywords(source).each(&:save)
    }

    errors.empty?
  end

  private

  def keywords(source)
    CSV.read(file).filter_map do |row_columns|
      keyword = Keyword.new(name: row_columns.to_csv.chomp, user_id: @current_user.id, source: source)

      keyword if keyword.valid?
    end
  end
end
