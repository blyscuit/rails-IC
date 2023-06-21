# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::SearchKeywordJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    context 'given a valid request' do
      it 'saves 3 as top_ads_count in the Database' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword

        expect(keyword.top_ads_count).to eq(3)
      end

      it 'saves 4 as total_ads_count in the Database' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword

        expect(keyword.total_ads_count).to eq(4)
      end

      it 'saves 6 ads_links in the Database' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword

        expect(keyword.ads_links.count).to eq(6)
      end

      it 'saves 10 as result_count in the Database' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword

        expect(keyword.result_count).to eq(10)
      end

      it 'saves 10 result_links in the Database' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword

        expect(keyword.result_links.count).to eq(10)
      end

      it 'saves 14 as total_link_count in the Database' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword

        expect(keyword.total_link_count).to eq(14)
      end

      it 'saves returned html as html in the Database' do
        html = file_fixture('html/valid_google.html').read
        stub_request(:get, %r{google.com/search}).to_return(body: html)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword

        expect(keyword.html).to eq(html)
      end

      it 'saves Google as source.name in the Database' do
        html = file_fixture('html/valid_google.html').read
        stub_request(:get, %r{google.com/search}).to_return(body: html)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword

        expect(keyword.source.name).to eq('Google')
      end
    end

    context 'given a 422 too many requests error' do
      it 'does not set any result' do
        stub_request(:get, %r{google.com/search}).to_return(status: 422)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword
      rescue Google::Errors::SearchKeywordError
        keyword.reload

        expect(
          [
            keyword.top_ads_count,
            keyword.total_ads_count,
            keyword.ads_links,
            keyword.result_count,
            keyword.result_links,
            keyword.total_link_count,
            keyword.html,
            keyword.source
          ]
        ).to all(be_nil)
      end

      it 'does not set the html attribute' do
        stub_request(:get, %r{google.com/search}).to_return(status: 422)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword
      rescue Google::Errors::SearchKeywordError

        expect(keyword.reload.html).not_to be_present
      end

      it 'performs a job with the right keyword' do
        stub_request(:get, %r{google.com/search}).to_return(status: 422)
        keyword = Fabricate(:keyword)

        allow(described_class).to receive(:perform_now)

        described_class.perform_now keyword

        expect(described_class).to have_received(:perform_now).with(keyword).exactly(:once)
      end
    end
  end
end
