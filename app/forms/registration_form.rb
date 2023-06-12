# frozen_string_literal: true

class RegistrationForm < ApplicationForm
  attr_accessor :email, :password, :password_confirmation, :client_id

  def initialize(sign_up_params)
    super
    @client_app = Doorkeeper::Application.find_by(uid: sign_up_params[:client_id])
    allowed_params = sign_up_params.except(:client_id)
    @user = User.new(allowed_params)
  end

  def save
    unless validate_client_id && @user.valid?
      errors.add(:user, @user.errors.full_messages.last) unless @user.errors.empty?
      return
    end

    @user.save
  end

  private

  def validate_client_id
    return true if @client_app

    errors.add(:client_id, I18n.t('doorkeeper.errors.messages.invalid_client'))
  end
end
