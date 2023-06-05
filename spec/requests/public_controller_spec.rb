# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicController, type: :request do
  describe 'GET#index' do
    it 'returns success status' do
      get '/public'

      expect(response).to have_http_status(:success)
    end
  end
end
