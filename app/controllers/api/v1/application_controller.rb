# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      before_action :doorkeeper_authorize!
    end
  end
end
