# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::SearchService, type: :service do
  describe '#call' do
    context 'given a keyword with valid results' do
      it 'performs http get with predefined headers' do
        headers = {
          'User-Agent' =>
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '\
          'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
        }
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn')
          .with(headers: headers)
          .to_return(body: file_fixture('html/valid_google.html').read)
        result = described_class.new('vpn').call
        expect(result[:ads_top_count]).not_to be_nil
      end

      it 'returns top ads count of 3' do
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn').to_return(body: file_fixture('html/valid_google.html').read)
        result = described_class.new('vpn').call
        expect(result[:ads_top_count]).to eq(3)
      end

      it 'returns total ads count of 4' do
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn').to_return(body: file_fixture('html/valid_google.html').read)
        result = described_class.new('vpn').call
        expect(result[:ads_page_count]).to eq(4)
      end

      it 'returns the url of the results that are ads' do
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn').to_return(body: file_fixture('html/valid_google.html').read)
        result = described_class.new('vpn').call
        expect(result[:ads_top_urls]).to contain_exactly('https://hubstaff.com/features/automatic-time-tracker', 'https://hubstaff.com/time_tracking_software', 'https://hubstaff.com/pricing', 'https://hubstaff.com/demo', 'https://www.odoo.com/app/timesheet', 'https://zapier.com/apps/timely-time-tracking/integrations')
      end

      it 'returns results count of 10' do
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn').to_return(body: file_fixture('html/valid_google.html').read)
        result = described_class.new('vpn').call
        expect(result[:result_count]).to eq(10)
      end

      it 'returns the url of the results that are not ads' do
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn').to_return(body: file_fixture('html/valid_google.html').read)
        result = described_class.new('vpn').call
        expect(result[:result_urls]).to contain_exactly('https://www.forbes.com/advisor/business/software/free-time-tracking-apps/', 'https://zapier.com/blog/best-time-tracking-apps/', 'https://clockify.me/', 'https://myhours.com/best-time-tracking-apps', 'https://toggl.com/', 'https://toggl.com/blog/best-time-tracking-apps', 'https://desktime.com/best-employee-time-tracking-software', 'https://play.google.com/store/apps/details?id=com.aloggers.atimeloggerapp&hl=en&gl=US', 'https://trackingtime.co/', 'https://collegeinfogeek.com/time-tracking-app/')
      end

      it 'returns total links count of 14' do
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn').to_return(body: file_fixture('html/valid_google.html').read)
        result = described_class.new('vpn').call
        expect(result[:total_link_count]).to eq(14)
      end

      it 'returns the html of the initial request' do
        html = file_fixture('html/valid_google.html').read
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn').to_return(body: html)
        result = described_class.new('vpn').call
        expect(result[:html]).to eq(html)
      end
    end

    context 'given a keyword with 500 status error result' do
      it 'returns nil' do
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn').to_return(status: 500)
        result = described_class.new('vpn').call
        expect(result).to be_nil
      end
    end

    context 'given the request returned an invalid html result' do
      it 'returns top ads count of 0' do
        stub_request(:get, 'https://www.google.com/search?gl=en&hl=en&q=vpn').to_return(body: '')
        result = described_class.new('vpn').call
        expect(result[:ads_top_count]).to eq(0)
      end
    end
  end
end
