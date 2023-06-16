# frozen_string_literal: true

Fabricator(:keyword) do
  id { FFaker::Identification.ssn }
  name { FFaker::FreedomIpsum.word }
end
