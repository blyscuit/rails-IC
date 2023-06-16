# frozen_string_literal: true

class PublicItemsController < ApplicationController
  def index
    render json: 'Nice to meet you'
  end
end
