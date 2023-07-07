# frozen_string_literal: true

require 'rails_helper'
require 'fixtures/fakes/o_auth_fake'

RSpec.describe User, type: :model do
  describe '.from_omniauth' do
    context 'given an existing user is found' do
      it 'returns the existing user' do
        auth = OmniAuth::AuthHash.new(OAuthFake.google)
        user = Fabricate(:user,
                         provider: auth['provider'],
                         uid: auth['uid'],
                         email: auth['info']['email'])

        expect(described_class.from_omniauth(auth)).to eq(user)
      end
    end

    context 'given a new user' do
      it 'creates a new user with the provided attributes' do
        auth = OmniAuth::AuthHash.new(OAuthFake.google)

        user = described_class.from_omniauth(auth)

        expect(user.provider).to eq(auth['provider'])
        expect(user.uid).to eq(auth['uid'])
        expect(user.email).to eq(auth['info']['email'])
      end

      it 'creates a new user' do
        auth = OmniAuth::AuthHash.new(OAuthFake.google)

        expect do
          described_class.from_omniauth(auth)
        end.to change(described_class, :count).by(1)
      end
    end

    context 'given an existing user with email provider' do
      it 'does NOT create a new user' do
        auth = OmniAuth::AuthHash.new(OAuthFake.google)
        Fabricate(:user,
                  provider: :email,
                  uid: auth['uid'],
                  email: auth['info']['email'])

        expect do
          described_class.from_omniauth(auth)
        end.not_to change(described_class, :count)
      end
    end
  end
end
