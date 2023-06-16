# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :request do
  describe 'POST#signup' do
    context 'given valid email and password' do
      it 'returns http status of created' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user).merge!(client_id: application.uid)
        post api_v1_registrations_path, params: params

        expect(response).to have_http_status(:created)
      end
    end

    context 'given duplicated email' do
      it 'returns http status of unprocessable content' do
        application = Fabricate(:application)
        user = Fabricate(:user)
        params = Fabricate.attributes_for(:user, email: user.email).merge!(client_id: application.uid)
        post api_v1_registrations_path, params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'given invalid client id' do
      it 'returns http status of unprocessable content' do
        params = Fabricate.attributes_for(:user).merge!(client_id: '')
        post api_v1_registrations_path, params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'given unmatched confirm password' do
      it 'returns http status of unprocessable content' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user, password_confirmation: '123').merge!(client_id: application.uid)
        post api_v1_registrations_path, params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
