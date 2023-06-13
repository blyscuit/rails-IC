# frozen_string_literal: true

class RegistrationForm < ApplicationForm
  def save(create_params)
    return false unless client_valid?(create_params[:client_id])

    user = User.new(create_params.except(:client_id))

    if user.invalid?
      errors.merge!(user.errors)

      return false
    end

    user.save
  end

  private

  def client_valid?(client_id)
    return true if Doorkeeper::Application.exists?(uid: client_id)

    errors.add(:client_id, I18n.t('doorkeeper.errors.messages.invalid_client'))

    false
  end
end
