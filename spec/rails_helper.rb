# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
require 'spec_helper'
require 'rspec/rails'
require 'json_matchers/rspec'
require 'pundit/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include OAuthHelpers

  config.around(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:type] == :feature ? :seeded : :transaction
    DatabaseCleaner.cleaning { example.run }
  end
end
