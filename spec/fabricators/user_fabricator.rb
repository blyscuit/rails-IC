# frozen_string_literal: true

Fabricator(:user) do
  email { FFaker::Internet.unique.email }
  password { 'password123' }
  password_confirmation { 'password123' }
  confirmed_at { 1.month.ago }
end
