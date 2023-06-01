# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Init' do
    let(:user) { Fabricate(:user) }

    it 'has email' do
      expect(user.email).not_to be_nil
    end
  end
end
