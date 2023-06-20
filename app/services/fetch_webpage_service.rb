# frozen_string_literal: true

class FetchWebpageService
  def initialize(url, headers)
    @uri = URI(url)
    @headers = headers
  end

  def call
    result = HTTParty.get(@uri, headers: @headers)

    return unless valid_result? result

    result
  rescue HTTParty::Error, Timeout::Error, SocketError
    nil
  end

  private

  def valid_result?(result)
    result&.response&.code == '200'
  end
end
