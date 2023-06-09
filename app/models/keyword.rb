# frozen_string_literal: true

class Keyword < ApplicationRecord
  include ActiveModel::API

  attr_accessor :id, :name

  has_many :keyword_users, dependent: :destroy
  has_many :users, through: :keyword_users
end
