# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Source, type: :model do
  context 'when creating two Sources with different cases' do
    it 'does NOT create a second source' do
      described_class.find_or_create_by({ name: 'nimble' })

      expect do
        described_class.find_or_create_by({ name: 'nImBle' })
      end.not_to change(described_class, :count)
    end
  end

  context 'when creating two Sources with different names' do
    it 'saves 2 sources' do
      described_class.find_or_create_by({ name: 'nimble1' })

      expect do
        described_class.find_or_create_by({ name: 'nimble2' })
      end.to change(described_class, :count).by(1)
    end
  end
end
