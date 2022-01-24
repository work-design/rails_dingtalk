module Dingtalk::Api
  class Saas < Base
    include Inner::Saas

    def token
      headers = sign_header('POST', '/gettoken.json')
      r = @client.post '/gettoken.json', headers: headers, base: app.base_url
      {
        'access_token' => r.dig('content', 'data', 'accessToken'),
        'expires_in' => r.dig('content', 'data', 'expiresIn')
      }
    end

    def post(path, params: {}, headers: {}, base: app.base_url, **payload)
      with_access_token('post', path, params, headers, payload) do |processed_params, processed_headers|
        @client.post path, payload.map(&->(k,v){ "#{k}=#{v}" }).sort!.join('&'), headers: processed_headers, params: processed_params, base: base
      end
    end

    protected
    def with_access_token(method, path, params = {}, headers = {}, payload = {}, tries = 2)
      app.refresh_access_token unless app.access_token_valid?
      payload.merge!(access_token: app.access_token)
      processed_headers = sign_header(method, path, params, payload)
      yield params, processed_headers
    rescue => e
      Rails.logger.debug e.full_message
      app.refresh_access_token
      retry unless (tries -= 1).zero?
    end

    def sign_header(method, path, params = {}, payload = {})
      headers = {
        apiKey: app.app_key,
        'X-Hmac-Auth-Timestamp': Time.current.to_formatted_s(:iso8601),
        'X-Hmac-Auth-Nonce': (Time.current.to_f * 1000).round.to_s + rand(1000..9999).to_s,
        'X-Hmac-Auth-Version': '1.0',
        'X-Hmac-Auth-IP': RailsDingtalk.config.ip,
        'X-Hmac-Auth-MAC': RailsDingtalk.config.mac
      }

      result = [
        method.upcase,
        headers[:'X-Hmac-Auth-Timestamp'],
        headers[:'X-Hmac-Auth-Nonce'],
        path
      ]
      if params.present? || payload.present?
        r = params.merge(payload)
        r = r.map(&->(k,v){ "#{k}=#{v}" }).sort!.join('&')
        result << r
      end
      signature = OpenSSL::HMAC.digest('SHA256', app.app_secret, result.join("\n"))
      headers.merge! 'X-Hmac-Auth-Signature': Base64.strict_encode64(signature)
    end

  end
end
