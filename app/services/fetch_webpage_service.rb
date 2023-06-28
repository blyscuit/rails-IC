# frozen_string_literal: true

class FetchWebpageService
  USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '\
               'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
  HEADERS = { 'User-Agent' => USER_AGENT }.freeze

  def initialize(url)
    @uri = URI(url)
  end

  def call
    result = HTTParty.get(@uri, headers: HEADERS)

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
