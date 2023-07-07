# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe Filter, type: :model do
#   describe 'filter_type' do
#     context 'given only adwords_url_contains' do
#       it 'returns NORMAL_FILTER' do
#         filter = described_class.new adwords_url_contains: 'word'

#         expect(filter.filter_type).to eq(Filter::NORMAL_FILTER)
#       end
#     end

#     context 'given only result_url_contains' do
#       it 'returns NORMAL_FILTER' do
#         filter = described_class.new result_url_contains: 'word'

#         expect(filter.filter_type).to eq(Filter::NORMAL_FILTER)
#       end
#     end

#     context 'given adwords_url_contains and result_url_contains' do
#       it 'returns NORMAL_FILTER' do
#         filter = described_class.new adwords_url_contains: 'another_word', result_url_contains: 'word'

#         expect(filter.filter_type).to eq(Filter::NORMAL_FILTER)
#       end
#     end

#     context 'given adwords_url_contains, result_url_contains and word' do
#       it 'returns NORMAL_FILTER' do
#         filter = described_class.new adwords_url_contains: 'another_word', result_url_contains: 'word', word: 'word'

#         expect(filter.filter_type).to eq(Filter::NORMAL_FILTER)
#       end
#     end

#     context 'given adwords_url_contains and word' do
#       it 'returns NORMAL_FILTER' do
#         filter = described_class.new adwords_url_contains: 'another_word', word: 'word'

#         expect(filter.filter_type).to eq(Filter::NORMAL_FILTER)
#       end
#     end

#     context 'given result_url_contains and word' do
#       it 'returns NORMAL_FILTER' do
#         filter = described_class.new result_url_contains: 'word', word: 'word'

#         expect(filter.filter_type).to eq(Filter::NORMAL_FILTER)
#       end
#     end

#     context 'given only word' do
#       it 'returns NO_FILTER' do
#         filter = described_class.new word: 'word'

#         expect(filter.filter_type).to eq(Filter::NO_FILTER)
#       end
#     end

#     context 'given only word' do
#       it 'returns NO_FILTER' do
#         filter = described_class.new match_at_least: 2

#         expect(filter.filter_type).to eq(Filter::NO_FILTER)
#       end
#     end

#     context 'given word and match_at_least' do
#       it 'returns MATCH_AT_LEAST_FILTER' do
#         filter = described_class.new word: 'word', match_at_least: 2

#         expect(filter.filter_type).to eq(Filter::MATCH_AT_LEAST_FILTER)
#       end
#     end

#     context 'given nil parameter' do
#       it 'returns NO_FILTER' do
#         filter = described_class.new nil

#         expect(filter.filter_type).to eq(Filter::NO_FILTER)
#       end
#     end
#   end
# end
