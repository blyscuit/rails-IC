# frozen_string_literal: true

class WebpageFetchService
  def initialize(url, user_agent)
    @uri = URI(url)
    @user_agent = user_agent
  end

  def call
    result = HTTParty.get(@uri, { headers: { 'User-Agent' => @user_agent } })

    return false unless valid_result? result

    result
  rescue HTTParty::Error, Timeout::Error, SocketError
    false
  end

  private

  def valid_result?(result)
    result&.response&.code == '200'
  end
end
