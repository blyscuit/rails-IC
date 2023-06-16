# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrivateItemsController, type: :request do
  describe 'GET#index' do
    context 'when the user is not signed in' do
      it 'redirects to the root page' do
        get private_items_path

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to('/')
      end
    end

    context 'when the user is signed in' do
      it 'returns success status' do
        sign_in Fabricate(:user)

        get private_items_path

        expect(response).to have_http_status(:success)
      end
    end
  end
end
