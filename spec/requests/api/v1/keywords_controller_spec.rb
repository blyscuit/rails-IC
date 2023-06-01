# frozen_string_literal: true

RSpec.describe Api::V1::KeywordsController, type: :controller do
  describe 'GET#index' do
    it 'returns the success status' do
      get :index

      expect(response).to have_http_status(:success)
    end

    it 'returns the valid keywords' do
      get :index
      keywords = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(keywords[0][:attributes][:name]).to eq('First keyword')
      expect(keywords[1][:attributes][:name]).to eq('Second keyword')
    end
  end
end