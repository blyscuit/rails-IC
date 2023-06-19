# frozen_string_literal: true

class SuccessMessagesController < ApplicationController
  def index
    render json: 'Success'
  end
end
