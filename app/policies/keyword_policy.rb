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
    user&.id.present? && user&.email.present?
  end
end
