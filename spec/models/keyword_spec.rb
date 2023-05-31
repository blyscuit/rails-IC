# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Keyword, type: :model do
  describe 'Init' do
    let(:keyword) { Fabricate(:keyword) }

    it 'has name' do
      expect(keyword.name).not_to be_nil
    end
  end
end
