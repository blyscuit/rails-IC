# frozen_string_literal: true

RSpec.describe Api::V1::KeywordsController, type: :request do
  describe 'GET#index' do
    it 'returns success status' do
      get api_v1_keywords_path

      expect(response).to have_http_status(:success)
    end

    it 'responds the valid keywords' do
      get api_v1_keywords_path

      keywords = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(keywords[0][:attributes][:name]).to eq('First keyword')
      expect(keywords[1][:attributes][:name]).to eq('Second keyword')
    end
  end
end
