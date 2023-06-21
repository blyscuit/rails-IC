# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::KeywordsController, type: :request do
  describe 'GET#index' do
    context 'given a logged in user gets theirs keyword' do
      it 'returns success status' do
        user = Fabricate(:user)
        Fabricate.times(3, :keyword, user_id: user.id)

        get api_v1_keywords_path, headers: create_token_header(user)

        expect(response).to have_http_status(:success)
      end

      it 'returns three items' do
        user = Fabricate(:user)
        Fabricate.times(3, :keyword, user_id: user.id)

        get api_v1_keywords_path, headers: create_token_header(user)

        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body[:data].count).to eq 3
      end
    end

    context 'given database contains keywords are not belonging to the current user' do
      it 'returns success status' do
        user = Fabricate(:user)
        Fabricate(:keyword, user_id: user.id)

        get api_v1_keywords_path, headers: create_token_header

        expect(response).to have_http_status(:success)
      end

      it 'returns an empty array' do
        user = Fabricate(:user)
        Fabricate(:keyword, user_id: user.id)

        get api_v1_keywords_path, headers: create_token_header

        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body[:data].count).to eq 0
      end
    end
  end

  describe 'POST#index' do
    context 'when CSV file is valid' do
      it 'returns success status' do
        params = { 'file' => fixture_file_upload('csv/valid.csv') }
        post api_v1_keywords_path, params: params, headers: create_token_header

        expect(response).to have_http_status(:success)
      end

      it 'saves 10 keywords to the DB' do
        params = { 'file' => fixture_file_upload('csv/valid.csv') }
        post api_v1_keywords_path, params: params, headers: create_token_header

        expect { post api_v1_keywords_path, params: params, headers: create_token_header }.to change(Keyword, :count).by(10)
      end

      it 'returns the upload_success meta message' do
        params = { 'file' => fixture_file_upload('csv/valid.csv') }
        post api_v1_keywords_path, params: params, headers: create_token_header

        expect(JSON.parse(response.body)['meta']).to eq(I18n.t('csv.upload_success'))
      end
    end

    context 'when CSV file is missing' do
      it 'returns unprocessable_entity status' do
        post api_v1_keywords_path, headers: create_token_header

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a invalid_file error' do
        post api_v1_keywords_path, headers: create_token_header

        expect(JSON.parse(response.body)['errors']['code']).to eq('invalid_file')
      end
    end

    context 'when CSV file is in the wrong type' do
      it 'returns unprocessable_entity status' do
        params = { 'file' => fixture_file_upload('csv/wrong_type.txt') }
        post api_v1_keywords_path, params: params, headers: create_token_header

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the wrong_type error' do
        params = { 'file' => fixture_file_upload('csv/wrong_type.txt') }
        post api_v1_keywords_path, params: params, headers: create_token_header

        expect(JSON.parse(response.body)['errors']['details']).to include(I18n.t('csv.validation.wrong_type'))
      end
    end

    context 'when user is not signed in' do
      it 'returns unauthorized status' do
        params = { 'file' => fixture_file_upload('csv/valid.csv') }
        post api_v1_keywords_path, params: params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
