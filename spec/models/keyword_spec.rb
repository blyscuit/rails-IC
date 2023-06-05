# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Keyword, type: :model do
  it 'exposes its name' do
    keyword = described_class.new(1, 'A keyword name')

    expect(keyword.name).to eq('A keyword name')
  end
end
