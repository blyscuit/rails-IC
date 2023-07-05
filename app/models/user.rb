# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def self.from_omniauth(auth)
    case auth.provider
    when :email
      return
    end
    find_existing_user(auth) || create_new_user(auth)
  end

  has_many :keywords, inverse_of: :user, dependent: :destroy
  enum provider: { email: 'email', google_oauth2: 'google_oauth2' }

  private_class_method def self.find_existing_user(auth)
    where(provider: auth.provider, uid: auth.uid, email: auth.info.email).first
  end

  private_class_method def self.create_new_user(auth)
    create do |user|
      user_attributes(user, auth)
    end
  end

  private_class_method def self.user_attributes(user, auth)
    user.email = auth.info.email
    user.provider = auth.provider
    user.uid = auth.uid
    user.password = Devise.friendly_token
  end
end
