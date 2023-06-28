# frozen_string_literal: true

class Source < ApplicationRecord
  has_many :keywords, inverse_of: :source, dependent: :nullify

  validates :name, uniqueness: { case_sensitive: false }
end
