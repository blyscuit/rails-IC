# frozen_string_literal: true

Fabricator(:user) do
  email { FFaker::Internet.email }
  password { 'password123' }
  password_confirmation { 'password123' }
end
