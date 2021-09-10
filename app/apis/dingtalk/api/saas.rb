module Dingtalk::Api
  class Saas < Base
    BASE = 'https://openplatform.dg-work.cn/'

    def token
      payload = {
        appkey: app.app_key,
        appsecret: app.app_secret,
      }
      r = @client.post 'gettoken.json', payload.to_json, headers: {  }, base: BASE
      {
        'access_token' => r.dig('content', 'data', 'accessToken'),
        'expires_in' => r.dig('content', 'data', 'expiresIn')
      }
    end

    def sign_header
      headers = {
        apiKey: app.app_key,
        'X-Hmac-Auth-Timestamp': Time.now.to_s(:iso8601),
        'X-Hmac-Auth-Nonce': (Time.now.to_f * 1000).round.to_s + rand(1000..9999).to_s,
        'X-Hmac-Auth-Version': '1.0',
        'X-Hmac-Auth-IP': RailsDingtalk.config.ip,
        'X-Hmac-Auth-MAC': RailsDingtalk.config.mac
      }

      
    end

    protected
    def with_access_token(params = {}, tries = 2)
      yield params.merge!(
        accessKey: app.app_key,
        secretKey: app.app_secret
      )
    rescue => e
      Rails.logger.debug e.full_message
      retry unless (tries -= 1).zero?
    end
  end
end
