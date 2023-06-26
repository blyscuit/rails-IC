# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::SearchKeywordJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    context 'given a valid request' do
      it 'saves 3 as ads_top_count' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.ads_top_count).to eq(3)
      end

      it 'saves 4 as ads_page_count' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.ads_page_count).to eq(4)
      end

      it 'saves 6 ads_top_urls' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.ads_top_urls.count).to eq(6)
      end

      it 'saves 10 as result_count' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.result_count).to eq(10)
      end

      it 'saves 10 result_urls' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.result_urls.count).to eq(10)
      end

      it 'saves 14 as total_link_count' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.total_link_count).to eq(14)
      end

      it 'saves returned html as html' do
        html = file_fixture('html/valid_google.html').read
        stub_request(:get, %r{google.com/search}).to_return(body: html)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.html).to eq(html)
      end

      it 'saves keyword status as parsed' do
        stub_request(:get, %r{google.com/search}).to_return(body: file_fixture('html/valid_google.html').read)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.status).to eq('parsed')
      end
    end

    context 'given a 422 too many requests error' do
      it 'does not set any result' do
        stub_request(:get, %r{google.com/search}).to_return(status: 422)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id
        keyword.reload

        expect(
          [
            keyword.ads_top_urls,
            keyword.result_urls,
            keyword.html,
            keyword.source
          ]
        ).to all(be_nil)
        expect(
          [
            keyword.ads_top_count,
            keyword.ads_page_count,
            keyword.result_count,
            keyword.total_link_count
          ]
        ).to all(eq(0))
      end

      it 'saves keyword status as failed' do
        stub_request(:get, %r{google.com/search}).to_return(status: 422)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.status).to eq('failed')
      end

      it 'does not set the html attribute' do
        stub_request(:get, %r{google.com/search}).to_return(status: 422)
        keyword = Fabricate(:keyword)

        described_class.perform_now keyword.id

        expect(keyword.reload.reload.html).not_to be_present
      end

      it 'performs a job with the right keyword' do
        stub_request(:get, %r{google.com/search}).to_return(status: 422)
        keyword = Fabricate(:keyword)
        keyword_id = keyword.id

        allow(described_class).to receive(:perform_now)

        described_class.perform_now keyword_id

        expect(described_class).to have_received(:perform_now).with(keyword_id).exactly(:once)
      end
    end
  end
end
