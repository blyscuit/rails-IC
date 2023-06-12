require 'rails_helper'
require 'byebug'

RSpec.describe RegistrationForm do
  describe '#save' do
    context 'given valid user input' do
      params = {
        email: "test+#{Time.now.to_i}@nimblehq.co",
        password: '123456',
        password_confirmation: '123456',
        client_id: Doorkeeper::Application.first(1).first.uid
      }
      it 'returns true' do
        form = described_class.new

        expect(form.save(params)).to be(true)
      end
    end

    context 'given user has entered a duplicated email' do
      params = {
        email: 'test@nimblehq.co',
        password: '123456',
        password_confirmation: '123456',
        client_id: Doorkeeper::Application.first(1).first.uid
      }

      it 'return nil' do
        form = described_class.new

        expect(form.save(params)).to be_nil
      end

      it 'has error messages' do
        form = described_class.new
        form.save(params)

        expect(form.errors.messages[:user]).to include('Email has already been taken')
      end
    end

    context 'given user has entered a different confirm password' do
      params = {
        email: "test+#{Time.now.to_i}@nimblehq.co",
        password: '123456',
        password_confirmation: '12456',
        client_id: Doorkeeper::Application.first(1).first.uid
      }

      it 'return nil' do
        form = described_class.new

        expect(form.save(params)).to be_nil
      end

      it 'has error messages' do
        form = described_class.new
        form.save(params)

        expect(form.errors.messages[:user]).to include('Password confirmation doesn\'t match Password')
      end
    end

    context 'given user has entered an invalid client id' do
      invalid_client_signup_params = {
        email: 'test@nimblehq.co',
        password: '123456',
        password_confirmation: '123456',
        client_id: 'client_id'
      }

      it 'return nil' do
        form = described_class.new

        expect(form.save(invalid_client_signup_params)).to be_nil
      end

      it 'has error messages' do
        form = described_class.new
        form.save(invalid_client_signup_params)

        expect(form.errors.messages[:client_id]).to include('Client authentication failed due to unknown client, no client '\
                                                            'authentication included, or unsupported authentication method.')
      end
    end
  end
end
