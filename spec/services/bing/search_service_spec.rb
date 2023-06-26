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
          'https://www.bing.com/aclick?ld=e8NiOyxy96RRlPcHWLIptRdzVUCUwpyTkbCn863TqIdMsH1ZMLO8JJw4h5zJTWisnqGtro_bvUu_0SJyEoA7v9taNholr7rCzZZ3vfKBAW3KZUCwC0xOg0nel4zJbtjoABCBZ4GE6oVb1giCZeTehOp40Ba_FqqkRAFYOZzLF8uHUIrIhP4GGnN3kU2o76fHyJ9G0V3Q&u=aHR0cHMlM2ElMmYlMmZiZXN0dmFsdWV2cG4uY29tJTJmY29tcGFyaXNvbi1jaGFydCUyZmJlc3QtdnBuJTJmJTNmdXRtX2NhbXBhaWduJTNkdnBuLWJpbmctc2VhcmNoLXNucC1kdC1yb3R3LWFsbC1lY3BjLWVuLWJlc3RfdG9wX3ZwbiUyNm1zY2xraWQlM2Q3ODU4MjBiOWYwYzgxN2M2ZWE4MjQ0MjBhMDliMzVhYSUyNnV0bV9zb3VyY2UlM2RiaW5nJTI2dXRtX21lZGl1bSUzZGNwYyUyNnV0bV90ZXJtJTNkdnBuJTI2dXRtX2NvbnRlbnQlM2RkdC1iZXN0X3RvcF92cG4&rlid=785820b9f0c817c6ea824420a09b35aa',
          'https://www.bing.com/aclick?ld=e8Qs40B3H7ujRKXiqcIMk4-DVUCUyh_Xpk7rX-uHtqDh3Ek9QMyO95sUF4QLI-fDB-NUwNgJMgmomg5cUCSY82exCmw56hkh9A41NhU7Ib1RO6Z4fO9fZ3_uY8ZnCc1ciB7W8aXYV-AqwkyxnXCr08i-LRW9XDPGMHqLgsIr4Okbh6AxOixO_xJQFk_bWewh5xnrzv-w&u=aHR0cHMlM2ElMmYlMmZ3d3cudG9wMTB2cG4uY29tJTJmdG9wMTAlMmZjb21wYXJlJTJmJTNmdiUzZGhlYWRlciUyNmJzaWQlM2RjMHNlNGt3MDYxJTI2bXNjbGtpZCUzZDFjZDVmNjM5Mjc1ZTFjNjhiOTI3OTJhMDc3MGQ2N2IzJTI2dXRtX3NvdXJjZSUzZGJpbmclMjZ1dG1fbWVkaXVtJTNkY3BjJTI2dXRtX2NhbXBhaWduJTNkR0VOLVJPVy1BTEwtQi1XRUItRU4lMjZ1dG1fdGVybSUzZHZwbiUyNnV0bV9jb250ZW50JTNkVlBOLUVY&rlid=1cd5f639275e1c68b92792a0770d67b3'
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
