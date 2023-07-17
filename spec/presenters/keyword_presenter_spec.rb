# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordPresenter do
  describe '#matching_adword_urls' do
    context 'given the urls contain the keyword vpn' do
      it 'has matching_adword_urls with 2 urls https://www.thetopvpn.com and https://www.nordvpn.com' do
        ads_top_urls = ['https://www.thetopvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
        keyword = Fabricate(:keyword, ads_top_urls: ads_top_urls)
        filter_params = { adwords_url_contains: 'vpn' }
        result = described_class.new(keyword, filter_params).matching_adword_urls

        expect(result).to eq(['https://www.thetopvpn.com', 'https://www.nordvpn.com'])
      end
    end

    context 'given the urls do not contain the keyword vpn' do
      it 'is empty' do
        ads_top_urls = ['https://www.google.com', 'https://www.bing.com', 'https://www.vnexpress.net']
        keyword = Fabricate(:keyword, ads_top_urls: ads_top_urls)
        filter_params = { adwords_url_contains: 'vpn' }
        result = described_class.new(keyword, filter_params).matching_adword_urls

        expect(result).to be_empty
      end
    end

    context 'given the keyword is nil' do
      it 'returns nil' do
        ads_top_urls = ['https://www.google.com', 'https://www.bing.com', 'https://www.vnexpress.net']
        keyword = Fabricate(:keyword, ads_top_urls: ads_top_urls)
        filter_params = { adwords_url_contains: nil }
        result = described_class.new(keyword, filter_params).matching_adword_urls

        expect(result).to be_nil
      end
    end

    context 'given result urls contain a word vpn' do
      it 'returns matching_result_urls with 2 urls https://www.topvpn.com and https://www.nordvpn.com' do
        result_urls = ['https://www.topvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
        keyword = Fabricate(:keyword, result_urls: result_urls)
        filter_params = { word: 'vpn', match_at_least: '1' }
        result = described_class.new(keyword, filter_params).matching_result_urls

        expect(result).to eq(['https://www.topvpn.com', 'https://www.nordvpn.com'])
      end
    end
  end
end
