# frozen_string_literal: true

class PrivateItemsController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: 'Welcome back'
  end
end
