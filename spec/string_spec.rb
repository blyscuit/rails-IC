# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'String' do
  context 'given a string number' do
    it 'returns an integer' do
      expect('100'.to_i).to eq(100)
    end
  end
end
