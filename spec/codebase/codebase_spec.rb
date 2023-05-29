# frozen_string_literal: true

require 'rails_helper'

describe 'Codebase', codebase: true do
  it 'does not offend scss-lint' do
    expect(`scss-lint ./`).to be_empty
  end

  it 'does not offend eslint' do
    expect(`yarn run eslint`).to include 'Done'
  end
end
