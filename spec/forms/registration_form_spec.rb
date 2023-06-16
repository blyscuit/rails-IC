# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationForm do
  describe '#save' do
    context 'given valid user input' do
      it 'returns true' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user).merge!(client_id: application.uid)
        form = described_class.new

        expect(form.save(params)).to be(true)
      end

      it 'has no error messsages' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user).merge!(client_id: application.uid)
        form = described_class.new
        form.save(params)

        expect(form.errors).to be_empty
      end
    end

    context 'given user has entered a duplicated email' do
      it 'returns false' do
        user = Fabricate(:user)
        params = Fabricate.attributes_for(:user, email: user.email).merge!(client_id: Fabricate(:application).uid)
        form = described_class.new

        expect(form.save(params)).to be false
      end

      it 'has error messages' do
        user = Fabricate(:user)
        params = Fabricate.attributes_for(:user, email: user.email).merge!(client_id: Fabricate(:application).uid)
        form = described_class.new
        form.save(params)

        expect(form.errors[:email]).to include('has already been taken')
      end
    end

    context 'given user has entered a different confirm password' do
      it 'returns false' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user, password_confirmation: '123').merge!(client_id: application.uid)
        form = described_class.new

        expect(form.save(params)).to be false
      end

      it 'has error messages' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user, password_confirmation: '123').merge!(client_id: application.uid)
        form = described_class.new
        form.save(params)

        expect(form.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end

    context 'given user has entered an invalid client id' do
      it 'returns false' do
        params = Fabricate.attributes_for(:user).merge!(client_id: '')
        form = described_class.new

        expect(form.save(params)).to be false
      end

      it 'has error messages' do
        params = Fabricate.attributes_for(:user).merge!(client_id: '')
        form = described_class.new
        form.save(params)

        expect(form.errors.messages[:client_id]).to include('Client authentication failed due to unknown client, no client '\
                                                            'authentication included, or unsupported authentication method.')
      end
    end

    context 'given user has entered an invalid email address' do
      it 'returns false' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user, email: 'test@nimblehq..co').merge!(client_id: application.uid)
        form = described_class.new

        expect(form.save(params)).to be false
      end

      it 'has error messsages' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user, email: 'test@nimblehq..co').merge!(client_id: application.uid)
        form = described_class.new
        form.save(params)

        expect(form.errors[:email]).to include('is invalid')
      end
    end

    context 'given user has entered an email address has sub domain' do
      it 'returns true' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user, email: 'test@nimblehq.dev.co').merge!(client_id: application.uid)
        form = described_class.new

        expect(form.save(params)).to be true
      end

      it 'has no error messsages' do
        application = Fabricate(:application)
        params = Fabricate.attributes_for(:user, email: 'test@nimblehq.dev.co').merge!(client_id: application.uid)
        form = described_class.new
        form.save(params)

        expect(form.errors).to be_empty
      end
    end
  end
end
