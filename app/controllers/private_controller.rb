# frozen_string_literal: true

class PrivateController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: "Welcome back"
  end
end
