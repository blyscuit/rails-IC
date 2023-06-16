# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Codebase', codebase: true do
  it 'does NOT break zeitwerk loading' do
    expect(`bundle exec rake zeitwerk:check`).to be_empty.or include 'All is good!'
  end
end
