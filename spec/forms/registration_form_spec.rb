require 'rails_helper'

RSpec.describe RegistrationForm do
  describe '#save' do
    context 'given valid user input' do
      it 'returns true' do
        form = described_class.new(valid_signup_params)

        expect(form.save).to be(true)
      end
    end

    context 'given user has entered a duplicated email' do
      it 'return nil' do
        form = described_class.new(duplicated_email_signup_params)

        expect(form.save).to be_nil
      end

      it 'has error messages' do
        form = described_class.new(duplicated_email_signup_params)
        form.save

        expect(form.errors.messages[:user]).to include('Email has already been taken')
      end
    end

    context 'given user has entered a different confirm password' do
      it 'return nil' do
        form = described_class.new(confirm_password_not_matched_signup_params)

        expect(form.save).to be_nil
      end

      it 'has error messages' do
        form = described_class.new(confirm_password_not_matched_signup_params)
        form.save

        expect(form.errors.messages[:user]).to include('Password confirmation doesn\'t match Password')
      end
    end

    context 'given user has entered an invalid client id' do
      it 'return nil' do
        form = described_class.new(invalid_client_signup_params)

        expect(form.save).to be_nil
      end

      it 'has error messages' do
        form = described_class.new(invalid_client_signup_params)
        form.save

        expect(form.errors.messages[:client_id]).to include('Client authentication failed due to unknown client, no client '\
                                                            'authentication included, or unsupported authentication method.')
      end
    end
  end

  private

  def valid_signup_params
    {
      email: "test+#{Time.now.to_i}@nimblehq.co",
      password: '123456',
      password_confirmation: '123456',
      client_id: 'sZl5c6GxwCI3YXuhSnjI6BiqfxQIy7wtobekdYu0k84'
    }
  end

  def duplicated_email_signup_params
    {
      email: 'test@nimblehq.co',
      password: '123456',
      password_confirmation: '123456',
      client_id: 'sZl5c6GxwCI3YXuhSnjI6BiqfxQIy7wtobekdYu0k84'
    }
  end

  def invalid_client_signup_params
    {
      email: 'test@nimblehq.co',
      password: '123456',
      password_confirmation: '123456',
      client_id: 'client_id'
    }
  end

  def confirm_password_not_matched_signup_params
    {
      email: "test+#{Time.now.to_i}@nimblehq.co",
      password: '123456',
      password_confirmation: '12456',
      client_id: 'client_id'
    }
  end
end
