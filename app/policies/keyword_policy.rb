# frozen_string_literal: true

class KeywordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(keywords: { user_id: user.id })
    end
  end

  def index?
    user_valid?
  end

  def create?
    user_valid?
  end

  def show?
    user_valid?
  end

  private

  def user_valid?
    user && !user.id.nil? && !user.email.nil?
  end
end
