# frozen_string_literal: true

Fabricator(:keyword) do
  on_init { init_with(FFaker::Identification.ssn, FFaker::FreedomIpsum.word) }
end
