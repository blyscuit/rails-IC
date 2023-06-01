# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PrivateController, type: :controller do
  describe 'GET#index' do
    context 'when user is not sign in' do
      it 'returns unauthorized error' do
        get :sample

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
