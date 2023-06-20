# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrivateItemsController, type: :request do
  describe 'GET#index' do
    context 'when the user is not signed in' do
      it 'returns unauthorized error' do
        get private_items_path

        expect(response).to have_http_status(:unauthorized)
      end
    end

    # TODO: configure mock token for Doorkeeper integration
    context 'when the user is signed in' do
      it 'returns success status' do
        header, = create_token_header
        get private_items_path, headers: header

        expect(response).to have_http_status(:success)
      end
    end
  end
end
