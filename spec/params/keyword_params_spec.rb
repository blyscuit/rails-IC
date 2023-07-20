# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordParams do
  describe '#initialize' do
    context('when init with adwords_url_contains') do
      it('has filter with only adwords_url_contains') do
        filter = { adwords_url_contains: 'word' }
        params = described_class.new filter

        expect(params.filter).to eq(filter)
      end
    end

    context('when init with result_url_contains') do
      it('has filter with only result_url_contains') do
        filter = { result_url_contains: 'word' }
        params = described_class.new filter

        expect(params.filter).to eq(filter)
      end
    end

    context('when init with result_url_contains and adwords_url_contains') do
      it('has filter with result_url_contains and adwords_url_contains') do
        filter = { result_url_contains: 'word', adwords_url_contains: 'second word' }
        params = described_class.new filter

        expect(params.filter).to eq(filter)
      end
    end

    context('when init with word') do
      it('has empty filter') do
        filter = { word: 'word' }
        params = described_class.new filter

        expect(params.filter).to eq({})
      end
    end

    context('when init with match_at_least') do
      it('has empty filter') do
        filter = { match_at_least: 2 }
        params = described_class.new filter

        expect(params.filter).to eq({})
      end
    end

    context('when init with match_at_least and word') do
      it('has filter with match_at_least and word') do
        filter = { match_at_least: 2, word: 'word' }
        params = described_class.new filter

        expect(params.filter).to eq(filter)
      end
    end

    context('when init with match_at_least and result_url_contains') do
      it('has filter with result_url_contains') do
        filter = { match_at_least: 2, result_url_contains: 'word' }
        params = described_class.new filter

        expect(params.filter).to eq({ result_url_contains: 'word' })
      end
    end

    context('when init with word and result_url_contains') do
      it('has filter with result_url_contains') do
        filter = { word: 'word', result_url_contains: 'word' }
        params = described_class.new filter

        expect(params.filter).to eq({ result_url_contains: 'word' })
      end
    end

    context('when init with word, match_at_least and result_url_contains') do
      it('has filter with result_url_contains') do
        filter = { match_at_least: 2, word: 'word', result_url_contains: 'word' }
        params = described_class.new filter

        expect(params.filter).to eq({ result_url_contains: 'word' })
      end
    end

    context('when init with word, match_at_least and adwords_url_contains') do
      it('has filter with adwords_url_contains') do
        filter = { match_at_least: 2, word: 'word', adwords_url_contains: 'word' }
        params = described_class.new filter

        expect(params.filter).to eq({ adwords_url_contains: 'word' })
      end
    end

    context('when init with word, match_at_least, adwords_url_contains and result_url_contains') do
      it('has filter with adwords_url_contains result_url_contains') do
        filter = { match_at_least: 2, word: 'word', adwords_url_contains: 'word', result_url_contains: 'second word' }
        params = described_class.new filter

        expect(params.filter).to eq({ adwords_url_contains: 'word', result_url_contains: 'second word' })
      end
    end

    context('when init with nil parameter') do
      it('has empty filter') do
        params = described_class.new

        expect(params.filter).to eq({})
      end
    end

    context('when init with empty parameter') do
      it('has empty filter') do
        filter = {}
        params = described_class.new filter

        expect(params.filter).to eq(filter)
      end
    end
  end
end
