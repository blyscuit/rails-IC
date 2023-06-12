# frozen_string_literal: true

require 'byebug'

class RegistrationForm < ApplicationForm
  def save(create_params)
    unless Doorkeeper::Application.find_by(uid: create_params[:client_id])
      errors.add(:client_id, I18n.t('doorkeeper.errors.messages.invalid_client'))

      return
    end

    user = User.new(create_params.except(:client_id))

    unless user.valid?
      errors.add(:user, user.errors.full_messages.last) unless user.errors.empty?

      return
    end

    user.save
  end
end
