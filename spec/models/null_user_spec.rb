# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NullUser, type: :model do
  describe '#id' do
    it 'returns nil' do
      expect(described_class.new.id).to be_nil
    end
  end

  describe '#email' do
    it 'returns nil' do
      expect(described_class.new.email).to be_nil
    end
  end
end
