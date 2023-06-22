# frozen_string_literal: true

class Keyword < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, inverse_of: :keywords
  belongs_to :source, inverse_of: :keywords, optional: true

  after_create_commit :perform_search

  private
  
  def perform_search
    # TODO: Perform "later"
    Google::SearchKeywordJob.perform_now id
  end
end
