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

    # rubocop:disable Rails/SkipsModelValidations
    Keyword.insert_all(keyword_hash)
    # rubocop:enable Rails/SkipsModelValidations

    errors.empty?
  end

  private

  def keyword_hash
    CSV.read(file).filter_map do |row|
      name = row.join(',')
      name.blank? ? false : { name: name, user_id: @current_user.id }
    end
  end
end
