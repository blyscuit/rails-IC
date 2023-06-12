# frozen_string_literal: true

class WebpageFetchService
  def initialize(url:)
    @escaped_keyword = CGI.escape(keyword)
    @uri = URI(url)
  end

  def call
    result = HTTParty.get(@uri, { headers: { 'User-Agent' => USER_AGENT } })

    return false unless valid_result? result

    result
  rescue HTTParty::Error, Timeout::Error, SocketError => e
    Rails.logger.error "Error: Query Google with '#{@escaped_keyword}' thrown an error: #{e}".colorize(:red)

    false
  end

  private

  def valid_result?(result)
    return true if result&.response&.code == '200'

    false
  end
end
