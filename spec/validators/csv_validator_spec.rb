# frozen_string_literal: true

require 'rails_helper'
require_relative './helper_models/csv_validator_helper'

RSpec.describe CsvValidator, type: :model do
  context 'given a valid file of 10 keywords' do
    it 'validates to valid' do
      form = CsvValidatorHelper.new(file_fixture('csv/valid.csv'))
      expect(form.valid?).to be(true)
    end
  end

  context 'given a valid file with blank keywords' do
    it 'validates to valid' do
      form = CsvValidatorHelper.new(file_fixture('csv/blank.csv'))
      expect(form.valid?).to be(true)
    end
  end

  context 'given a file with 1001 keywords' do
    it 'returns wrong_count error' do
      form = CsvValidatorHelper.new(file_fixture('csv/exceed_count.csv'))
      form.validate
      expect(form.errors.full_messages).to include(I18n.t('csv.validation.wrong_count'))
    end

    it 'validates to invalid' do
      form = CsvValidatorHelper.new(file_fixture('csv/exceed_count.csv'))
      expect(form.valid?).to be(false)
    end
  end

  context 'given a file with type txr' do
    it 'returns wrong_type error' do
      form = CsvValidatorHelper.new(file_fixture('csv/wrong_type.txt'))
      form.validate
      expect(form.errors.full_messages).to include(I18n.t('csv.validation.wrong_type'))
    end

    it 'validates to invalid' do
      form = CsvValidatorHelper.new(file_fixture('csv/wrong_type.txt'))
      expect(form.valid?).to be(false)
    end
  end
end
