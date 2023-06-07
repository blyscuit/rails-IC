# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PrivateItemsController, type: :request do
  describe 'GET#index' do
    context 'when the user is unauthenticated' do
      it 'returns unauthorized status' do
        get api_v1_private_sample_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
