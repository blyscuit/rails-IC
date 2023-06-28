# frozen_string_literal: true

class Keyword < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, inverse_of: :keywords
  belongs_to :source, inverse_of: :keywords, optional: true
  enum status: { in_progress: 'in_progress', parsed: 'parsed', failed: 'failed' }

  after_create_commit :perform_search

  private

  def perform_search
      SearchKeywordJob.perform_later id
end
