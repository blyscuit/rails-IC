# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Codebase', codebase: true do
  it 'does NOT offend Rubocop' do
    expect(`rubocop --parallel --format simple`).to include 'no offenses detected'
  end

  it 'satisfies Brakeman' do
    expect(`brakeman -w1`).not_to include '+SECURITY WARNINGS+'
  end

  it 'does NOT break zeitwerk loading' do
    expect(`bundle exec rake zeitwerk:check`).to be_empty
  end
end
