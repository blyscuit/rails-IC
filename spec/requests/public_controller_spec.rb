# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  describe 'GET#index' do
    it 'returns expected status' do
      get :index

      expect(response).to have_http_status(:success)
    end
  end
end
