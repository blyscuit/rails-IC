# frozen_string_literal: true

require 'byebug'

class RegistrationForm < ApplicationForm
  def save(create_params)
    return unless validate_client(create_params[:client_id])

    user = User.new(create_params.except(:client_id))

    unless user.valid?
      user_error = user.errors
      errors.add(:user, user_error.full_messages.last) unless user_error.empty?

      return
    end

    user.save
  end

  private

  def validate_client(client_id)
    unless Doorkeeper::Application.find_by(uid: client_id)
      errors.add(:client_id, I18n.t('doorkeeper.errors.messages.invalid_client'))

      return
    end

    true
  end
end
