# frozen_string_literal: true

Fabricator(:source) do
  name { FFaker::Company.unique.name }
end
