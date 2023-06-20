class Source < ApplicationRecord
  has_many :keywords, inverse_of: :source, dependent: :nullify
end
