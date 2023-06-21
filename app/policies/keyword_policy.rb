# frozen_string_literal: true

class KeywordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(keywords: { user_id: user.id })
    end
  end
end
