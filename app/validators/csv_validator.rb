# frozen_string_literal: true

require 'csv'

class CsvValidator < ActiveModel::Validator
  CSV_EXTENSION = '.csv'

  def validate(csv_form)
    file = csv_form.file
    add_error(csv_form, :wrong_count) unless valid_count(file)
    add_error(csv_form, :wrong_type) unless valid_extension(file)
  end

  private

  def add_error(csv_form, type)
    csv_form.errors.add(:base, I18n.t("csv.validation.#{type}"))
  end

  def valid_count(file)
    CSV.read(file).count.between?(1, 1000)
  end

  def valid_extension(file)
    File.extname(file) == CSV_EXTENSION
  end
end
