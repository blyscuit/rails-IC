# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::KeywordsController, type: :controller do
  describe 'GET#index' do
    it 'returns expected status' do
      get :index

      expect(response).to have_http_status(:success)
    end

    it 'returns response with valid keyword' do
      get :index
      keywords = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:name]

      expect(keywords).to eq('Hello')
    end
  end
end
