# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TokensController, type: :routing do
  describe 'POST#login' do
    it 'routes to token#create' do
      expect(post: api_v1_login_path).to route_to('api/v1/tokens#create')
    end
  end
end