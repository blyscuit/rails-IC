# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Csv::CsvImportService do
  describe '#call' do
    context 'given a valid file of 10 keywords' do
      it 'saves 10 keywords with the correct user' do
        user = Fabricate(:user)
        csv_import_service = described_class.new(user)
        csv_import_service.call(fixture('files/csv/valid.csv').path)
        expect(
          Keyword.where(
            id: KeywordUser.where(
              user_id: user.id
            )
          ).count
        ).to eq(10)
      end
    end

    context 'given a nil file path' do
      it 'does not save any keyword' do
        user = Fabricate(:user)
        csv_import_service = described_class.new(user)
        csv_import_service.call(nil)
        expect(
          Keyword.where(
            id: KeywordUser.where(
              user_id: user.id
            )
          ).count
        ).to eq(0)
      end
    end
  end
end
