# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchWebpageService, type: :service do
  describe '#call' do
    context 'when querying a webpage returns success response' do
      it 'returns an HTTParty Response' do
        url = FFaker::Internet.http_url
        stub_request(:get, url)
        result = described_class.new(url).call

        expect(result).to be_an_instance_of(HTTParty::Response)
      end
    end

    context 'when querying a webpage returns 500 error' do
      it 'returns nil' do
        url = FFaker::Internet.http_url
        stub_request(:get, url).to_return(status: 500)
        result = described_class.new(url).call

        expect(result).to be_nil
      end
    end
  end
end
