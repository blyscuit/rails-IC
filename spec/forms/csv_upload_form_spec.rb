# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvUploadForm, type: :form do
  SOURCE_NAME = 'source_name'
  describe '#save' do
    context 'given a valid file of 10 keywords' do
      it 'can save' do
        stub_request(:get, %r{google.com/search})
        user = Fabricate(:user)
        form = described_class.new(user)
        saved = form.save(file_fixture('csv/valid.csv'), SOURCE_NAME)

        expect(saved).to be(true)
      end

      it 'saves 10 keywords with the correct user' do
        stub_request(:get, %r{google.com/search})
        user = Fabricate(:user)
        form = described_class.new(user)
        form.save(file_fixture('csv/valid.csv'), SOURCE_NAME)

        expect(keyword_for_user(user).count).to eq(10)
      end

      it 'saves same 10 keywords from the file' do
        stub_request(:get, %r{google.com/search})
        user = Fabricate(:user)
        form = described_class.new(user)
        form.save(file_fixture('csv/valid.csv'), SOURCE_NAME)
        csv_entries = CSV.read(File.open(form.file)).map { |str| str.join(',') }

        expect(csv_entries).to match_array(keyword_for_user(user))
      end

      it 'saves 10 keywords with source from the input' do
        stub_request(:get, %r{google.com/search})
        user = Fabricate(:user)
        form = described_class.new(user)
        form.save(file_fixture('csv/valid.csv'), SOURCE_NAME)
        csv_entries = CSV.read(File.open(form.file)).map { |str| str.join(',') }
        source = Source.where(:name => SOURCE_NAME).first

        expect(Keyword.where(:source => source).count).to eq(10)
      end
    end

    context 'given a nil file path' do
      it 'does not save any keyword' do
        user = Fabricate(:user)
        form = described_class.new(user)

        expect { form.save(nil, SOURCE_NAME) }.not_to change(Keyword, :count)
      end
    end

    context 'given too many keywords' do
      it 'returns a wrong_count error' do
        user = Fabricate(:user)
        form = described_class.new(user)
        form.save(file_fixture('csv/exceed_count.csv'), SOURCE_NAME)

        expect(form.errors.full_messages).to include(I18n.t('csv.validation.wrong_count'))
      end
    end

    context 'given a none CSV file' do
      it 'returns the wrong_type error' do
        user = Fabricate(:user)
        form = described_class.new(user)
        form.save(file_fixture('csv/wrong_type.txt'), SOURCE_NAME)

        expect(form.errors.full_messages).to include(I18n.t('csv.validation.wrong_type'))
      end
    end

    context 'given a file with 9 keywords and 1 blank' do
      it 'saves 9 keywords with the correct user' do
        stub_request(:get, %r{google.com/search})
        user = Fabricate(:user)
        form = described_class.new(user)
        form.save(file_fixture('csv/blank.csv'), SOURCE_NAME)

        expect(keyword_for_user(user).count).to eq(9)
      end
    end

    private

    def keyword_for_user(user)
      Keyword.where(user: user.id).map(&:name)
    end
  end
end
