# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Source, type: :model do
  context 'when creating two Sources with different cases' do
    it 'saves 1 source' do
      expect do
        described_class.find_or_create_by({ name: 'nimble' })
        described_class.find_or_create_by({ name: 'nImBle' })
      end.to change(described_class, :count).by(1)
    end
  end

  context 'when creating two Sources with different names' do
    it 'saves 2 sources' do
      expect do
        described_class.find_or_create_by({ name: 'nimble1' })
        described_class.find_or_create_by({ name: 'nimble2' })
      end.to change(described_class, :count).by(2)
    end
  end
end
