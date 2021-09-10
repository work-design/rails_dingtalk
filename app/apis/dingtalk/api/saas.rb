module Dingtalk::Api
  class Saas < Base
    BASE = 'https://openplatform.dg-work.cn/'

    def token
      payload = {
        appkey: app.app_key,
        appsecret: app.app_secret,
      }
      r = @client.post 'gettoken.json', payload.to_json, base: BASE
      {
        'access_token' => r.dig('content', 'data', 'accessToken'),
        'expires_in' => r.dig('content', 'data', 'expiresIn')
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
