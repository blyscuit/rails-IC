# frozen_string_literal: true

class ApplicationParams
  def initialize(params = {})
    @params = params
  end

  protected

  attr_reader :params

  def handle_param(param_name)
    param_value = params&.dig(param_name)
    return if param_value.blank?

    param_value
  end
end
