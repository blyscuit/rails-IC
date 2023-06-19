# frozen_string_literal: true

RSpec.describe Api::V1::KeywordsController, type: :request do
  describe 'GET#index' do
    it 'returns success status' do
      header, = create_token_header

      get api_v1_keywords_path, headers: header

      expect(response).to have_http_status(:success)
    end

    it 'returns the valid keywords' do
      header, = create_token_header

      get api_v1_keywords_path, headers: header

      keywords = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(keywords[0][:attributes][:name]).to eq('First keyword')
      expect(keywords[1][:attributes][:name]).to eq('Second keyword')
    end
  end

  describe 'POST#index' do
    context 'when csv file is valid' do
      it 'returns success status' do
        header, = create_token_header
        params = { 'file' => fixture_file_upload('csv/valid.csv') }
        post api_v1_keywords_path, params: params, headers: header

        expect(response).to have_http_status(:success)
      end

      it 'saves 10 keywords to the DB' do
        header, = create_token_header
        params = { 'file' => fixture_file_upload('csv/valid.csv') }
        post api_v1_keywords_path, params: params, headers: header

        expect { post api_v1_keywords_path, params: params, headers: header }.to change(Keyword, :count).by(10)
      end

      it 'returns the upload_success meta message' do
        header, = create_token_header
        params = { 'file' => fixture_file_upload('csv/valid.csv') }
        post api_v1_keywords_path, params: params, headers: header

        expect(JSON.parse(response.body)['meta']).to eq(I18n.t('csv.upload_success'))
      end
    end

    context 'when csv file is missing' do
      it 'returns unprocessable_entity status' do
        header, = create_token_header
        post api_v1_keywords_path, headers: header

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a invalid_file error' do
        header, = create_token_header
        post api_v1_keywords_path, headers: header

        expect(JSON.parse(response.body)['errors']['code']).to eq('invalid_file')
      end
    end

    context 'when csv file is in the wrong type' do
      it 'returns unprocessable_entity status' do
        header, = create_token_header
        params = { 'file' => fixture_file_upload('csv/wrong_type.txt') }
        post api_v1_keywords_path, params: params, headers: header

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a wrong_type error' do
        header, = create_token_header
        params = { 'file' => fixture_file_upload('csv/wrong_type.txt') }
        post api_v1_keywords_path, params: params, headers: header

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
