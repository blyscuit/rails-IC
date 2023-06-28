# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bing::SearchService, type: :service do
  describe '#call' do
    context 'given a keyword with valid results' do
      it 'performs http get with predefined headers' do
        headers = {
          'user-agent' =>
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '\
          'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
        }
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH')
          .with(headers: headers)
          .to_return(body: file_fixture('html/valid_bing.html').read)

        result = described_class.new('vpn').call

        expect(result[:ads_top_count]).not_to be_nil
      end

      it 'returns top ads count of 2' do
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH').to_return(body: file_fixture('html/valid_bing.html').read)

        result = described_class.new('vpn').call

        expect(result[:ads_top_count]).to eq(2)
      end

      it 'returns the url of the results that are ads' do
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH').to_return(body: file_fixture('html/valid_bing.html').read)

        result = described_class.new('vpn').call

        expect(result[:ads_top_urls]).to contain_exactly(
          'https://www.bing.com/aclick?ld=LONG-ID_of_THE_1ST_ADS_TOP_URL',
          'https://www.bing.com/aclick?ld=LONG-ID_of_THE_2ND_ADS_TOP_URL'
        )
      end

      it 'returns total ads count of 7' do
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH').to_return(body: file_fixture('html/valid_bing.html').read)

        result = described_class.new('vpn').call

        expect(result[:ads_page_count]).to eq(7)
      end

      it 'returns results count of 4' do
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH').to_return(body: file_fixture('html/valid_bing.html').read)

        result = described_class.new('vpn').call

        expect(result[:result_count]).to eq(4)
      end

      it 'returns the url of the results that are not ads' do
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH').to_return(body: file_fixture('html/valid_bing.html').read)

        result = described_class.new('vpn').call

        expect(result[:result_urls]).to contain_exactly(
          'https://www.avira.com/en/free-vpn',
          'https://www.pcmag.com/picks/the-best-vpn-services',
          'https://chrome.google.com/webstore/detail/free-vpn-for-chrome-vpn-p/majdfhpaihoncoakbjgbdhglocklcgno',
          'https://www.techradar.com/vpn/best-free-vpn'
        )
      end

      it 'returns total links count of 11' do
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH').to_return(body: file_fixture('html/valid_bing.html').read)

        result = described_class.new('vpn').call

        expect(result[:total_link_count]).to eq(11)
      end

      it 'returns the html of the initial request' do
        html = file_fixture('html/valid_bing.html').read
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH').to_return(body: html)

        result = described_class.new('vpn').call

        expect(result[:html]).to eq(html)
      end
    end

    context 'given a keyword with 500 status error result' do
      it 'returns nil' do
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH').to_return(status: 500)

        result = described_class.new('vpn').call

        expect(result).to be_nil
      end
    end

    context 'given the request returned an invalid html result' do
      it 'returns top ads count of 0' do
        stub_request(:get, 'https://www.bing.com/search?q=vpn&form=QBLH').to_return(body: '')

        result = described_class.new('vpn').call

        expect(result[:ads_top_count]).to eq(0)
      end
    end
  end
end
