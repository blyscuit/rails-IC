# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordsQuery, type: :query do
  describe '#call' do
    context 'given the user searches for ads_top_urls' do
      context 'given ads_top_urls contain the filtering word vpn' do
        it 'returns 2 keywords' do
          ads_top_urls = ['https://www.thetopvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
          Fabricate.times(2, :keyword, ads_top_urls: ads_top_urls)
          filter_params = { adwords_url_contains: 'vpn' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords.count).to eq 2
        end
      end

      context 'given ads_top_urls does not contain the filtering word apple' do
        it 'returns an empty array' do
          ads_top_urls = ['https://www.thetopvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
          Fabricate.times(2, :keyword, ads_top_urls: ads_top_urls)
          filter_params = { adwords_url_contains: 'apple' }
          keywords = described_class.new(Keyword, filter_params).call
          
          expect(keywords).to be_empty
        end
      end
    end

    context 'when querying with adwords_url_contains' do
      context 'when user has keyword' do
        context 'given filter_params is nil' do
          it 'returns Keyword scope' do
            keywords = described_class.new(Keyword, nil).call
  
            expect(keywords).to eq Keyword
          end
        end

        context 'when querying with no parameters' do
          it 'returns Keyword scope' do
            keywords = described_class.new(Keyword, {}).call
  
            expect(keywords).to eq Keyword
          end
        end
        
        context 'when there are urls containing the word vpn' do
          it 'returns 2 keywords' do
            ads_top_urls = ['https://www.thetopvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
            Fabricate.times(2, :keyword, ads_top_urls: ads_top_urls)

            filter_params = { adwords_url_contains: 'vpn' }
            keywords = described_class.new(Keyword, filter_params).call

            expect(keywords.count).to eq 2
          end
        end

        context 'when there is no urls containing the word vpn' do
          it 'returns empty array for keywords' do
            ads_top_urls = ['https://www.thetop.com', 'https://www.nord.com', 'https://www.vnexpress.net']
            Fabricate(:keyword, ads_top_urls: ads_top_urls)

            filter_params = { adwords_url_contains: 'vpn' }
            keywords = described_class.new(Keyword, filter_params).call

            expect(keywords).to be_empty
          end
        end
      end
    end

    context 'when querying with result_url_contains' do
      context 'when there are search urls containing the word vpn' do
        it 'returns 2 keywords' do
          result_urls = ['https://www.thetopvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
          Fabricate.times(2, :keyword, result_urls: result_urls)

          filter_params = { result_url_contains: 'vpn' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords.count).to eq 2
        end
      end

      context 'when there is no urls containing the word vpn' do
        it 'returns empty array for keywords' do
          Fabricate(:keyword)

          filter_params = { result_url_contains: 'vpn' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords).to be_empty
        end
      end
    end

    context 'when querying with adwords_url_contains and result_url_contains' do
      context 'when there are urls containing the query words' do
        it 'returns 2 keywords' do
          ads_top_urls = ['https://www.thetopvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
          result_urls = ['https://www.topgame.com']
          Fabricate.times(2, :keyword, ads_top_urls: ads_top_urls, result_urls: result_urls)

          filter_params = { adwords_url_contains: 'vpn', result_url_contains: 'game' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords.count).to eq 2
        end
      end

      context 'when there is no urls containing the adwords_url_contains word' do
        it 'returns empty array for keywords' do
          ads_top_urls = ['https://www.thetop.com', 'https://www.nord.com', 'https://www.vnexpress.net']
          result_urls = ['https://www.topgame.com']
          Fabricate(:keyword, ads_top_urls: ads_top_urls, result_urls: result_urls)

          filter_params = { adwords_url_contains: 'vpn', result_url_contains: 'game' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords).to be_empty
        end
      end

      context 'when there is no urls containing the result_url_contains word' do
        it 'returns empty array for keywords' do
          ads_top_urls = ['https://www.vpn.com']
          result_urls = ['https://www.top.com']
          Fabricate(:keyword, ads_top_urls: ads_top_urls, result_urls: result_urls)

          filter_params = { adwords_url_contains: 'vpn', result_url_contains: 'game' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords).to be_empty
        end
      end

      context 'when there is no urls containing the query words' do
        it 'returns empty array for keywords' do
          ads_top_urls = ['https://www.vvv.com']
          result_urls = ['https://www.top.com']
          Fabricate(:keyword, ads_top_urls: ads_top_urls, result_urls: result_urls)

          filter_params = { adwords_url_contains: 'vpn', result_url_contains: 'game' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords).to be_empty
        end
      end
    end

    context 'given the user search by word and match at least' do
      context 'given the user search for a word vpn and match at least 1' do
        it 'return a keyword' do
          result_urls = ['https://www.thetopvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
          keyword = Fabricate(:keyword, result_urls: result_urls)
          filter_params = { word: 'vpn', match_at_least: '1' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords).to contain_exactly(keyword)
        end
      end

      context 'given filtering with a word vpn and match at least 2' do
        it 'returns a keyword' do
          result_urls = ['https://www.topvpn.com/vpn', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
          keyword = Fabricate(:keyword, result_urls: result_urls)
          filter_params = { word: 'vpn', match_at_least: '2' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords).to contain_exactly(keyword)
        end
      end

      context 'given there is no matched result' do
        it 'is empty' do
          result_urls = ['https://www.topvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
          Fabricate(:keyword, result_urls: result_urls)
          filter_params = { word: 'missing', match_at_least: '2' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords).to be_empty
        end
      end

      context 'given word parameter is vpn and match_at_least parameter nil' do
        it 'returns Keyword scope' do
          filter_params = { word: 'vpn' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords.all).to eq Keyword.all
        end
      end

      context 'given match_at_least parameter is 1 and word parameter nil' do
        it 'returns all the keywords' do
          filter_params = { match_at_least: '1' }
          keywords = described_class.new(Keyword, filter_params).call

          expect(keywords.all).to eq Keyword.all
        end
      end
    end

    context 'given the user input 3 paramters adwords_url_contains, word and match_at_least' do
      it 'returns results for the filter adwords_url_contains' do
        ads_top_urls = ['https://www.google.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
        result_urls = ['https://www.thetopvpn.com', 'https://www.nordvpn.com', 'https://www.vnexpress.net']
        Fabricate(:keyword, result_urls: result_urls)
        keyword = Fabricate(:keyword, ads_top_urls: ads_top_urls, result_urls: result_urls)
        filter_params = { adwords_url_contains: 'vnexpress', word: 'nordvpn', match_at_least: '1' }
        keywords = described_class.new(Keyword, filter_params).call

        expect(keywords).to contain_exactly(keyword)
      end
    end
  end
end
