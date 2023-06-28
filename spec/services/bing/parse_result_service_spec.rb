# frozen_string_literal:true

require 'rails_helper'

RSpec.describe Bing::ParseResultService, type: :service do
  describe '#call' do
    context 'given a valid Bing page' do
      it 'returns top ads count of 2' do
        result = described_class.new(file_fixture('html/valid_bing.html').read).call

        expect(result[:ads_top_count]).to eq(2)
      end

      it 'returns total ads count of 7' do
        result = described_class.new(file_fixture('html/valid_bing.html').read).call

        expect(result[:ads_page_count]).to eq(7)
      end

      it 'returns the url of the results that are ads' do
        result = described_class.new(file_fixture('html/valid_bing.html').read).call

        expect(result[:ads_top_urls]).to contain_exactly(
          'https://www.bing.com/aclick?ld=LONG-ID_of_THE_1ST_ADS_TOP_URL',
          'https://www.bing.com/aclick?ld=LONG-ID_of_THE_2ND_ADS_TOP_URL'
        )
      end

      it 'returns results count of 4' do
        result = described_class.new(file_fixture('html/valid_bing.html').read).call

        expect(result[:result_count]).to eq(4)
      end

      it 'returns the url of the results that are not ads' do
        result = described_class.new(file_fixture('html/valid_bing.html').read).call

        expect(result[:result_urls]).to contain_exactly(
          'https://www.avira.com/en/free-vpn',
          'https://www.pcmag.com/picks/the-best-vpn-services',
          'https://chrome.google.com/webstore/detail/free-vpn-for-chrome-vpn-p/majdfhpaihoncoakbjgbdhglocklcgno',
          'https://www.techradar.com/vpn/best-free-vpn'
        )
      end

      it 'returns total links count of 11' do
        result = described_class.new(file_fixture('html/valid_bing.html').read).call

        expect(result[:total_link_count]).to eq(11)
      end

      it 'returns the html of the initial request' do
        html = file_fixture('html/valid_bing.html').read

        result = described_class.new(html).call

        expect(result[:html]).to eq(html)
      end
    end
  end
end
