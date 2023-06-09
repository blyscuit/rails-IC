# frozen_string_literal: true

class KeywordUser < ApplicationRecord
  belongs_to :keyword
  belongs_to :user
end
