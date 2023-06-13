# frozen_string_literal: true

class CsvValidatorHelper
  include ActiveModel::Validations

  attr_reader :file

  validates_with CsvValidator

  def initialize(file)
    @file = file
  end
end
