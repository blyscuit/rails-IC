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
          'https://www.bing.com/aclick?ld=e8NiOyxy96RRlPcHWLIptRdzVUCUwpyTkbCn863TqIdMsH1ZMLO8JJw4h5zJTWisnqGtro_bvUu_0SJyEoA7v9taNholr7rCzZZ3vfKBAW3KZUCwC0xOg0nel4zJbtjoABCBZ4GE6oVb1giCZeTehOp40Ba_FqqkRAFYOZzLF8uHUIrIhP4GGnN3kU2o76fHyJ9G0V3Q&u=aHR0cHMlM2ElMmYlMmZiZXN0dmFsdWV2cG4uY29tJTJmY29tcGFyaXNvbi1jaGFydCUyZmJlc3QtdnBuJTJmJTNmdXRtX2NhbXBhaWduJTNkdnBuLWJpbmctc2VhcmNoLXNucC1kdC1yb3R3LWFsbC1lY3BjLWVuLWJlc3RfdG9wX3ZwbiUyNm1zY2xraWQlM2Q3ODU4MjBiOWYwYzgxN2M2ZWE4MjQ0MjBhMDliMzVhYSUyNnV0bV9zb3VyY2UlM2RiaW5nJTI2dXRtX21lZGl1bSUzZGNwYyUyNnV0bV90ZXJtJTNkdnBuJTI2dXRtX2NvbnRlbnQlM2RkdC1iZXN0X3RvcF92cG4&rlid=785820b9f0c817c6ea824420a09b35aa',
          'https://www.bing.com/aclick?ld=e8Qs40B3H7ujRKXiqcIMk4-DVUCUyh_Xpk7rX-uHtqDh3Ek9QMyO95sUF4QLI-fDB-NUwNgJMgmomg5cUCSY82exCmw56hkh9A41NhU7Ib1RO6Z4fO9fZ3_uY8ZnCc1ciB7W8aXYV-AqwkyxnXCr08i-LRW9XDPGMHqLgsIr4Okbh6AxOixO_xJQFk_bWewh5xnrzv-w&u=aHR0cHMlM2ElMmYlMmZ3d3cudG9wMTB2cG4uY29tJTJmdG9wMTAlMmZjb21wYXJlJTJmJTNmdiUzZGhlYWRlciUyNmJzaWQlM2RjMHNlNGt3MDYxJTI2bXNjbGtpZCUzZDFjZDVmNjM5Mjc1ZTFjNjhiOTI3OTJhMDc3MGQ2N2IzJTI2dXRtX3NvdXJjZSUzZGJpbmclMjZ1dG1fbWVkaXVtJTNkY3BjJTI2dXRtX2NhbXBhaWduJTNkR0VOLVJPVy1BTEwtQi1XRUItRU4lMjZ1dG1fdGVybSUzZHZwbiUyNnV0bV9jb250ZW50JTNkVlBOLUVY&rlid=1cd5f639275e1c68b92792a0770d67b3'
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
