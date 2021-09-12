module Dingtalk::Api
  class Saas < Base
    include Inner::Saas
    BASE = 'https://openplatform.dg-work.cn/'

    def token
      headers = sign_header('POST', '/gettoken.json')
      r = @client.post 'gettoken.json', nil, headers: headers, base: BASE
      {
        'access_token' => r.dig('content', 'data', 'accessToken'),
        'expires_in' => r.dig('content', 'data', 'expiresIn')
      }
    end

    def sign_assess_header(method, path, params = {})

      sign_header(method, path, params = {})
    end

    protected
    def with_access_token(method, path, params = {}, headers = {}, tries = 2)
      app.refresh_access_token unless app.access_token_valid?
      processed_headers = sign_header(method, path, params = {})
      yield params.merge!(access_token: app.access_token), processed_headers
    rescue => e
      Rails.logger.debug e.full_message
      app.refresh_access_token
      retry unless (tries -= 1).zero?
    end

    def sign_header(method, path, params = {})
      headers = {
        apiKey: app.app_key,
        'X-Hmac-Auth-Timestamp': Time.now.strftime('%Y-%m-%dT%H:%M:%S.%3N%:z'),
        'X-Hmac-Auth-Nonce': (Time.now.to_f * 1000).round.to_s + rand(1000..9999).to_s,
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
      result << params.to_query if params.present?
      signature = OpenSSL::HMAC.digest('SHA256', app.app_secret, result.join("\n"))
      headers.merge! 'X-Hmac-Auth-Signature': Base64.strict_encode64(signature)
    end

  end
end
