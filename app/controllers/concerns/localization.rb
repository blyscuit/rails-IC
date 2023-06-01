# frozen_string_literal: true

module Localization
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale

    protected

    def switch_locale(&action)
      locale = extract_locale_from_header || I18n.default_locale

      I18n.with_locale(locale, &action)
    end

    def extract_locale_from_header
      accepted_langauge = request.headers[:'Accept-Language']
      return accepted_langauge if I18n.locale_available?(accepted_langauge)

      nil
    end
  end
end
