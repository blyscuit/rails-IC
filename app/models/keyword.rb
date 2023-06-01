# frozen_string_literal: true

class Keyword
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end
