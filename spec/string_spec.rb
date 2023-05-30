# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'String' do
  context 'when converting to integer' do
    it 'has correct value' do
      expect('100'.to_i).to eq(100)
    end
  end
end
