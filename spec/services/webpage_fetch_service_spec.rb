# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebpageFetchService, type: :service do
  describe '#call' do
    context 'when querying a webpage returns success response' do
      it 'returns an HTTParty Response' do
        url = FFaker::Internet.http_url
        WebMock.stub_request(:get, url)
        result = described_class.new(url, nil).call

        expect(result).to be_an_instance_of(HTTParty::Response)
      end
    end

    context 'when querying a webpage with User-Agent' do
      it 'returns an HTTParty Response' do
        url = FFaker::Internet.http_url
        user_agent = FFaker::FreedomIpsum.word
        WebMock.stub_request(:get, url)
          .with(headers: { 'User-Agent' => user_agent })
        result = described_class.new(url, user_agent).call

        expect(result).to be_an_instance_of(HTTParty::Response)
      end
    end

    context 'when querying a webpage returns 500 error' do
      it 'returns false' do
        url = FFaker::Internet.http_url
        puts url
        WebMock.stub_request(:get, url).to_return(status: 500)
        result = described_class.new(url, nil).call

        expect(result).to eq(false)
      end
    end
  end
end
