# frozen_string_literal: true

class PublicController < ApplicationController
  def index
    render json: "Nice to meet you"
  end
end
