# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicItemsController, type: :request do
  describe 'GET#index' do
    it 'returns success status' do
      get public_items_path

      expect(response).to have_http_status(:success)
    end
  end
end
