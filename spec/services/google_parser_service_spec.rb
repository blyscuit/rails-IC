# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoogleParserService do
  describe '#call' do
    context 'given a valid google page' do
      it 'returns 3 top ads count' do
        result = described_class.new(file_fixture('html/valid_google.html').read).call
        expect(result[:ads_top_count]).to eq(3)
      end

      it 'returns 4 total ads count' do
        result = described_class.new(file_fixture('html/valid_google.html').read).call
        expect(result[:ads_page_count]).to eq(4)
      end

      it 'returns the correct ads urls' do
        result = described_class.new(file_fixture('html/valid_google.html').read).call
        expect(result[:ads_top_urls]).to contain_exactly('https://hubstaff.com/features/automatic-time-tracker', 'https://hubstaff.com/time_tracking_software', 'https://hubstaff.com/pricing', 'https://hubstaff.com/demo', 'https://www.odoo.com/app/timesheet', 'https://zapier.com/apps/timely-time-tracking/integrations')
      end

      it 'returns 10 results count' do
        result = described_class.new(file_fixture('html/valid_google.html').read).call
        expect(result[:result_count]).to eq(10)
      end

      it 'returns the correct result urls' do
        result = described_class.new(file_fixture('html/valid_google.html').read).call
        expect(result[:result_urls]).to contain_exactly('https://www.forbes.com/advisor/business/software/free-time-tracking-apps/', 'https://zapier.com/blog/best-time-tracking-apps/', 'https://clockify.me/', 'https://myhours.com/best-time-tracking-apps', 'https://toggl.com/', 'https://toggl.com/blog/best-time-tracking-apps', 'https://desktime.com/best-employee-time-tracking-software', 'https://play.google.com/store/apps/details?id=com.aloggers.atimeloggerapp&hl=en&gl=US', 'https://trackingtime.co/', 'https://collegeinfogeek.com/time-tracking-app/')
      end

      it 'returns 14 total links count' do
        result = described_class.new(file_fixture('html/valid_google.html').read).call
        expect(result[:total_link_count]).to eq(14)
      end

      it 'returns correct html' do
        html = file_fixture('html/valid_google.html').read
        result = described_class.new(html).call
        expect(result[:html]).to eq(html)
      end
    end
  end
end
